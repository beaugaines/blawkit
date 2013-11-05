class CommentsController < ApplicationController
  before_filter :ensure_post

  def create
    @comment = current_user.comments.build(params[:comment].merge!(post: @post))
    if @comment.save
      redirect_to @post, notice: 'Comment added'
    else
      render 'new', alert: 'Comment not saved; please try again'
    end
  end

  private

  def ensure_post
    redirect_to topic_posts_path, alert: 'No such post' unless post
  end

  def post
    @post ||= Post.find_by_id(params[:post_id])
  end
  
  helper_method :post

end
