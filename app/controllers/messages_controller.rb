class MessagesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @message = Message.new
  end

  def create
    @message = current_user.images.new(params[:message])
    if @message.save
      redirect_to dashboard_path, :notice => "Message posted succesfully."
    else
      flash[:alert] = "There was an error."
      render 'new'
    end
  end

end
