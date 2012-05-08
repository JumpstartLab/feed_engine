class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      redirect_to dashboard_path, :notice => "Message posted succesfully."
    else
      flash[:alert] = "There was an error."
      render 'new'
    end
  end

end
