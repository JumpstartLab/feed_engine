class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  def show
    flash[:notice] = params[:message] if params[:message]
    @growl  = current_user.growls.build
    @growls = current_user.growls.by_date.page(params[:page])
  end
end
