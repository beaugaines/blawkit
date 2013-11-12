class PostsController < ApplicationController
  before_filter :ensure_post, only: [:edit, :update, :show]
  before_filter :ensure_topic
  before_filter :authenticate_user!

  def show
    @comment = current_user.comments.build
    @comments = @post.comments
  end

  def new
    @post = Post.new
    authorize! :create, Post, message: 'You need to be a member to create a post'
  end

  def create
    @post = current_user.posts.build(params[:post])
    @post.topic = @topic
    authorize! :create, @post, message: 'You need to be signed up to do that'
    if @post.save
      redirect_to :back, notice: 'Post saved'
    else
      render :new, alert: 'There was an error saving your post.  Please try again.'
    end
  end
  

  def edit
    render
    authorize! :edit, @post, message: 'You need to own the post to edit it'
  end

  def update
    authorize! :update, @post, message: 'You ned to own the post to edit it'
    if @post.update_attributes(params[:post])
      redirect_to [@topic, @post], notice: 'Post updated'
    else
      render :edit, alert: 'Post not updated; try again'
    end
  end

  def destroy
    title = @post.title
    authorize! :destroy, @post, message: 'You need to own the post to delete it'
    if @post.destroy
      redirect_to @topic, message: "#{name} was deleted successfully"
    else
      render :show, error: 'There was an error deleting the post'
    end
  end
  
  

  private

  def ensure_post
    redirect_to topics_path, alert: 'No such post' unless post
  end

  def post
    @post ||= Post.find_by_id(params[:id])
  end

  def ensure_topic
    redirect_to topics_path, alert: 'No such topic' unless topic
  end

  def topic
    @topic ||= Topic.find_by_id(params[:topic_id])
  end
  
  helper_method :post
  helper_method :topic
  
end
