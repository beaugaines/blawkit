class CommentsController < ApplicationController
  respond_to :html, :js

  before_filter :ensure_post
  # before_filter :ensure_topic 

  def create
    @comment = current_user.comments.build(params[:comment].merge!(post: @post))
    if @comment.save
      respond_with(@comment)
   # respond_to do |format|
      #if @comment.save
        #format.html { redirect_to topics_path, notice: 'Comment added' }
        #format.js
        #format.json { render action: 'show', status: :created }
      #else
        #format.html { render 'new', alert: 'Comment not saved; please try again' }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
   #   end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    # authorize! :destroy, @comment, message: 'You need to own the comment to do delete it'
    if @comment.destroy
      redirect_to [@topic, @post], notice: 'Comment was removed'
    else
      redirect_to [@topic, @post], error: 'Comment could not be deleted.  Try again'
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
