# The controller for the dashboard that is used for posting and settings
class DashboardController < ApplicationController

  def show
    @message = Message.new
    @image = Image.new
    @link = Link.new
  end
end
