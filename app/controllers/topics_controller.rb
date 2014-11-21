class TopicsController < ApplicationController
  before_filter :ensure_topic, only: [:show, :edit, :update, :destroy]

  def index
    #@topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 5)
    @topics = Topic.visible_to(current_user)
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
    @posts = @topic.posts.includes(:user).paginate(page: params[:page], per_page: 5)
  end

  def edit
    authorize! :update, @topic, message: 'You must be admin to do that'
  end

  def destroy
    name = @topic.name
    authorize! :destroy, @topic, message: 'You need to be admin to do that'
    if @topic.destroy
      # redirect_to topics_path, notice: "#{name} was deleted successfully"
      redirect_to topics_path, notice: "Topic was deleted successfully"
    else
      render :show, error: 'There was an error deleting this topic'
    end
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
