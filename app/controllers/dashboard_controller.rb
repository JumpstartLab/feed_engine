# The controller for the dashboard that is used for posting and settings
class DashboardController < ApplicationController
  before_filter :authorize

  def show
    flash[:notice] = params[:notice] if params[:notice]
    @message = Message.new
    @image = Image.new
    @link = Link.new
  end
end
