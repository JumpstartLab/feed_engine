class SubscriptionsController < ApplicationController
  def create
    if current_user && params[:feed_name] && !params[:feed_name].eql?("null")
      sub = current_user.subscribe(params[:feed_name])
    end
    if sub && sub.valid?
       head :status => :created
     else
       head :status => :not_acceptable
     end
  end
  
  def index
    @subscriptions = current_user.subscriptions if current_user
    if @subscriptions
      render "index",
      :status => :ok,
      :handlers => [:jbuilder]
    else
      head :status => :unauthorized
    end
  end
  
  def destroy
    sub = current_user.subscriptions.find_by_feed_id(params[:feed_id]) if current_user
    unless sub && sub.destroy
      head :status => :unauthorized
    else
      @subscriptions = current_user.subscriptions
      render "index",
      :status => :ok,
      :handlers => [:jbuilder]
    end
  end
end
