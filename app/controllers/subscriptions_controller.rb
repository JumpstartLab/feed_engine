class SubscriptionsController < ApplicationController
  def create
    subscription = current_user.inverse_subscriptions.build(user_id: params["user_id"],
                                                            last_status_id: DateTime.now.to_i)
    render :json => subscription.save
  end

  def destroy
    subscription = current_user.inverse_subscriptions.where(user_id: params["user_id"]).first
    render :json => subscription.destroy
  end
end
