class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user_id, :post_id

  delegate :username, to: :user
end
