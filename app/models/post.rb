class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic
  has_many :comments
  belongs_to :user
  belongs_to :topic

  mount_uploader :image, ImageUploader

  delegate :username, to: :user

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :title, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
