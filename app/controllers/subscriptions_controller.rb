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
end
