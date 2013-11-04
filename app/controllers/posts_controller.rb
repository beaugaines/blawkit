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
