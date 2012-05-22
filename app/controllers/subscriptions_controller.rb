class SubscriptionsController < ApplicationController
  def create
    subscription = current_user.inverse_subscriptions.build(user_id: params["user_id"],
                                                            last_status_id: DateTime.now.to_i)
    @response = subscription.save

    respond_to do |format|
      format.js {render :content_type => 'text/javascript'}
    end
    # render :js => "alert #{subscription.save}", :layout => false
  end

  def destroy
    subscription = current_user.inverse_subscriptions.where(user_id: params["user_id"]).first
    render :js => "alert #{subscription.destroy}", :layout => false
  end
end
