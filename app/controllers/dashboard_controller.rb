class DashboardController < ApplicationController

  def show
    @message = Message.new
    @image = Image.new
    @link = Link.new
  end
end
