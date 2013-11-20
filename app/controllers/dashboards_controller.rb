class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.new(current_user)
    @posts = Post.visible_to(current_user).
      in_last_week.
      paginate(page: params[:page], per_page: 5).
      includes(:topic)
  end
end
