class Post < ActiveRecord::Base
  attr_accessible :body, :title
  has_many :comments
  belongs_to :user

  delegate :username, to: :user
end
