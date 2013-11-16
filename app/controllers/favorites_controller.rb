class FavoritesController < ApplicationController

  before_filter :setup

  def create
    favorite = current_user.favorites.create(post: @post)
    if favorite.valid?
      redirect_to [@topic, @post], notice: 'Favorited post'
    else
      redirect_to [@topic, @post], alert: 'Unable to add favorite. Please try again.'
    end
  end

  private

  def setup
    redirect_to topics_path, alert: 'Invalid associations' unless set_associations
    # authorize! :create, Vote, message: 'You must be a user to do that'
  end

  def set_associations
    @topic ||= Topic.find_by_id(params[:topic_id])
    @post ||= @topic.posts.find_by_id(params[:post_id])
  end
      
end
