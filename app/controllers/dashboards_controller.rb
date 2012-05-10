class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @image = Image.new
    @message = Message.new
    @link = Link.new
    @growls = Growl.by_date.page(params[:page])
  end
end
