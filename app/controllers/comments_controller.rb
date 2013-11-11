class CommentsController < ApplicationController
  before_filter :ensure_post

  def create
    @comment = current_user.comments.build(params[:comment].merge!(post: @post))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topics_path, notice: 'Comment added' }
        format.js
        format.json { render action: 'show', status: :created }
      else
        format.html { render 'new', alert: 'Comment not saved; please try again' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
