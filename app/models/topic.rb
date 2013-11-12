class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts, dependent: :destroy

  default_scope order('created_at DESC')
end
