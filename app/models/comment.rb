class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user, :post

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  delegate :username, to: :user

  after_create :send_favorite_emails

  default_scope order('created_at DESC')

  def user_avatar
    user.avatar.small.url if user.avatar?
  end

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if favorite.user_id != self.user_id && favorite.user.email_favorites?
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end

end
