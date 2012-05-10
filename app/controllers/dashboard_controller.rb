class DashboardController < ApplicationController
  before_filter :authorize

  def show
    @message = Message.new
    @image = Image.new
    @link = Link.new
  end
end
