class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user, :post

  delegate :username, to: :user

  default_scope order('created_at DESC')

  def user_avatar
    user.avatar.small.url
  end
  
end
