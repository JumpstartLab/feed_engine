class DashboardsController < ApplicationController
  def show
    @growls = Growl.all
  end
end
