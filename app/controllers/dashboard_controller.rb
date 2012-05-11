# The controller for the dashboard that is used for posting and settings
class DashboardController < ApplicationController
  before_filter :authorize

  def show
    @message = Message.new
    @image = Image.new
    @link = Link.new
    @user = current_user
  end
end
