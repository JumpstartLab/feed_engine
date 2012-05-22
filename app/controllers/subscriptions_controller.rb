# For dealing with external subscriptions
class SubscriptionsController < ApplicationController
  def new

  end

  def create
    auth_response = request.env["omniauth.auth"]
    Subscription.create_with_omniauth(auth_response, current_user)
    notice = "Your account has been linked with #{auth_response["provider"]}"
    if current_user.subscribed_to_all_services? || authorized_from_dashboard
      redirect_to dashboard_path, notice: notice
    else
      redirect_to new_subscription_path, notice: notice
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    if @subscription.destroy
      redirect_to :back, notice: "#{@subscription.provider} has been removed."
    else
      notice = "#{@subscription.provider} could not be removed."
      redirect_to :back, notice: notice
    end
  end

  private

  def authorized_from_dashboard
    request.env["HTTP_REFERER"].include?("dashboard")
  end

end
