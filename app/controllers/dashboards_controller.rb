class DashboardsController < ApplicationController
  def show
    @image = Image.new
    @message = Message.new
    @link = Link.new
    @growls = Growl.by_date.page(params[:page])
  end
end
