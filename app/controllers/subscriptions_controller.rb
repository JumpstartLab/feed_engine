class SubscriptionsController < ApplicationController
  def new

  end

  def create
    Subscription.create_with_omniauth(request.env["omniauth.auth"], current_user)
    provider = request.env["omniauth.auth"]["provider"]
    notice = "Your account has been linked with #{provider}"
    if current_user.subscriptions.count < num_subscriptions
      redirect_to new_subscription_path, notice: notice
    else
      redirect_to dashboard_path, notice: notice
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    if @subscription.destroy
      redirect_to :back, notice: "#{@subscription.provider} has been removed."
    else
      redirect_to :back, notice: "#{@subscription.provider} could not be removed."
    end
  end

  private

  def num_subscriptions
    2
  end

end
