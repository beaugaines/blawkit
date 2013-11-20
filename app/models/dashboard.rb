class Dashboard

  def initialize user
    @user = user
  end

  attr_reader :user

  def username
    user.username
  end

  def popular_posts
    Post.visible_to(@user).in_last_week
  end
      
end
  