class DashboardsController < ApplicationController
  def show
    @growls = Growl.by_date.page(params[:page])
  end
end
