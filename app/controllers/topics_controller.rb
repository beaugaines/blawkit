class TopicsController < ApplicationController
  before_filter :ensure_topic, only: [:show, :edit, :update]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: 'You must be admin to do that'
  end

  def create
    @topic =Topic.new(params[:topic])
    if @topic.save
      redirect_to @topic, notice: 'Topic created'
    else
      render :new, alert: 'Topic creation failed; please try again'
    end
  end

  def update
    if @topic.update_attributes(params[:topic])
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
  end

  def show
  end

  def edit
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
