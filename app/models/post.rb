class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic
  has_many :comments
  belongs_to :user
  belongs_to :topic

  delegate :username, to: :user

  default_scope order('created_at DESC')
end
