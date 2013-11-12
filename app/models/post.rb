class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic, :image, :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  mount_uploader :image, ImageUploader

  delegate :username, to: :user

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
