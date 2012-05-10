class DashboardsController < ApplicationController
  def show
    @growls = Growl.all
    @image = Image.new
    @message = Message.new
    @link = Link.new
  end
end
