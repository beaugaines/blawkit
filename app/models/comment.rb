class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user, :post

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  delegate :username, to: :user

  default_scope order('created_at DESC')

  def user_avatar
    user.avatar.small.url if user.avatar?
  end
  
end
