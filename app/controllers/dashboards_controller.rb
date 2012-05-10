class DashboardsController < ApplicationController
  def show
<<<<<<< HEAD
    @growls = Growl.all
=======
    @growls = Growl.by_date.page(params[:page])
>>>>>>> 990c2e8acfda63d5485a9878233a9a02d9bbfc81
    @image = Image.new
    @message = Message.new
    @link = Link.new
  end
end
