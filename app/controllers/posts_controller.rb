class PostsController < ApplicationController
  before_filter :ensure_post, only: [:edit, :show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, notice: 'Post saved'
    else
      render 'new', alert: 'There was an error saving your post.  Please try again.'
  end
  

  def edit
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
