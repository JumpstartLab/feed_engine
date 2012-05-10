require 'twitter'

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(params[:message])
    @message.send_to_services

    if @message.save
      redirect_to dashboard_path, :notice => "Message posted succesfully."
    else
      flash[:alert] = "There was an error."
      render 'new'
    end
  end
end

# Twitter::Client.new(:consumer_key => 'IXDAm8E6f0HOHLeJ2uZcTQ', :consumer_secret => 'piDvbV8wfzBklu4d2UOXSKeFRPEecAIzCZJF0JM', :oauth_token => '500861259-5ADrlugyc0uKTNIs3RPJaSXrrFxh2AvlWH8BombO', :oauth_token_secret => 'lpaJ9fuW4qLq4vKqNtC3JdHAdUV4Mi1nxsTcIfsw')
