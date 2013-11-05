class TopicsController < ApplicationController
  before_filter :ensure_topic, only: [:show, :edit, :update]

  def index
    @topics = Topic.includes(:posts)
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: 'You must be admin to do that'
  end

  def create
    @topic =Topic.new(params[:topic])
    authorize! :create, @topic, message: 'You must be admin to do that'
    if @topic.save
      redirect_to @topic, notice: 'Topic created'
    else
      render :new, alert: 'Topic creation failed; please try again'
    end
  end

  def update
    authorize! :update, @topic, message: 'You need to own the topic to update it'
    if @topic.update_attributes(params[:topic])
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
  end

  def show
    @posts = @topic.posts
  end

  def edit
    authorize! :update, @topic, message: 'You must be admin to do that'
  end

  private

  def ensure_topic
    redirect_to root_path, notice: 'No such topic' unless topic
  end

  def topic
    @topic ||= Topic.find_by_id(params[:id])
  end
  
  helper_method :topic
  
end
