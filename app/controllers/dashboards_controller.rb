class DashboardsController < ApplicationController
  def show
    @growl  = current_user.growls.build
    @growls = current_user.growls.by_date.page(params[:page])
  end
end
