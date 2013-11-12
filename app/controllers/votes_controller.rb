class VotesController < ApplicationController

  before_filter :setup

  def up_vote
    update_vote(1)
    redirect_to :back
  end
  
  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  private

  def update_vote(value)
    if vote
      @vote.update_attribute(:value, value)
    else
      @vote = current_user.votes.create(value: value, post: @post)
    end
  end

  def setup
    redirect_to topics_path, alert: 'Invalid associations' unless set_associations
    authorize! :create, Vote, message: 'You must be a user to do that'
  end

  def set_associations
    @topic ||= Topic.find_by_id(params[:topic_id])
    @post ||= @topic.posts.find_by_id(params[:post_id])
  end

  def vote
    @vote ||= @post.votes.find_by_user_id(current_user.id)
  end

  helper_method :set_assocations
  helper_method :vote
  
end