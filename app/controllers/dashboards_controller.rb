class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @growl  = current_user.growls.build
    @growls = current_user.growls.by_date.page(params[:page])
  end
end
