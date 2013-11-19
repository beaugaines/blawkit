class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic, :image, :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  after_create :create_vote

  mount_uploader :image, ImageUploader

  delegate :username, to: :user

  default_scope order('rank DESC')

  scope :visible_to, lambda { |user| user ? scoped : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end
  
  def down_votes
    votes.where(value: -1).count
  end

  def increment_view_count
    count = self.view_count
    update_attribute(:view_count, count.succ)
    update_rank
  end

  def points
    votes.sum(:value).to_i
  end

  def update_rank
    age = (self.created_at - Time.at(0)) / 86400
    new_rank = points + age + view_count + comments.count
    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end
  
  
end
