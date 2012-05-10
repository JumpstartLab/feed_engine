class DashboardsController < ApplicationController
  def show
    # @growls = Growl.by_date.page(params[:page])
    @image = Image.new
    @message = Message.new
    @link = Link.new
  end
end
