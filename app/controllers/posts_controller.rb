class PostsController < ApplicationController
  before_filter :ensure_post, only: [:edit, :show]
  before_filter :authenticate_user!

  # def index
  #   @posts = Post.all
  # end

  def show
    @comment = current_user.comments.build
  end

  def new
    @post = Post.new
    authorize! :create, Post, message: 'You need to be a member to create a post'
  end

  def create
    @post = current_user.posts.build(params[:post])
    authorize! :create, @post, message: 'You need to be signed up to do that'
    if @post.save
      redirect_to @post, notice: 'Post saved'
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
      redirect_to @post, notice: 'Post updated'
    else
      render :edit, alert: 'Post not updated; try again'
    end
  end
  

  private

  def ensure_post
    redirect_to topic_posts_path, alert: 'No such post' unless post
  end

  def post
    @post ||= Post.find_by_id(params[:id])
  end
  
  helper_method :post
  
end
