class CommentsController < ApplicationController
  respond_to :html, :js

  before_filter :ensure_post
  # before_filter :ensure_topic 

  def create
    @comment = current_user.comments.build(params[:comment].merge!(post: @post))
    authorize! :create, @comment, message: 'You need to be signed in to do that'
    if @comment.save
      redirect_to [@post.topic, @post], notice: 'Comment created'
    else
      redirect_to [@post.topic, @post], alert: 'Comment creation failed'
    end

      @new_comment = Comment.new
      respond_with(@comment) do |f|
        f.html { redirect_to [@post.topic, @post] }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message: 'You need to own the comment to do delete it'
    if @comment.destroy
      respond_with(@comment) do |f|
        f.html { redirect_to [@post.topic, @post] }
      end
    end
  end


  private

  def ensure_post
    redirect_to topics_path, alert: 'No such post' unless post
  end

  def post
    @post ||= Post.find_by_id(params[:post_id])
  end

  def ensure_topic
    redirect_to topic_posts_path, alert: 'No such topic' unless topic
  end

  def post
    @post ||= Post.find_by_id(params[:post_id])
  end

  helper_method :post
  helper_method :topic

end
