class SubscriptionsController < ApplicationController
  def create
    subscription = current_user.inverse_subscriptions.build(user_id: params["user_id"],
                                                            last_status_id: DateTime.now.to_i)
    @response = subscription.save
    render json: "Created"
  end

  def destroy
    subscription = current_user.inverse_subscriptions.where(user_id: params["user_id"]).first
    subscription.destroy
    render json: "Destroyed"
  end
end
