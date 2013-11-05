class PostsController < ApplicationController
  before_filter :ensure_post, only: [:edit, :show]

  def index
    @posts = Post.all
  end

  def show
    @comment = current_user.comments.build
  end

  def new
    @post = Post.new
    authorize! :create, Post, message: 'You need to be a member to create a post'
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      redirect_to @post, notice: 'Post saved'
    else
      render :new, alert: 'There was an error saving your post.  Please try again.'
    end
  end
  

  def edit
    render
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post, notice: 'Post updated'
    else
      render :edit, alert: 'Post not updated; try again'
    end
  end
  

  private

  def ensure_post
    redirect_to posts_path, alert: 'No such post' unless post
  end

  def post
    @post ||= Post.find_by_id(params[:id])
  end
  
  helper_method :post
  
end
