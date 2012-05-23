class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @subscriptions = current_user.inverse_subscribers
  end

  def create
    subscription = current_user.inverse_subscriptions.build(user_id: params["id"],
                                                            last_status_id: DateTime.now.to_i)
    @response = subscription.save
    render json: "Created"
  end

  def destroy
    subscription = current_user.inverse_subscriptions.where(user_id: params["id"]).first
    subscription.destroy
    render json: "Destroyed"
  end

end
