class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def show
    session[:authentication_workflow] = dashboard_path
    @post = current_user.posts.new
  end

end
