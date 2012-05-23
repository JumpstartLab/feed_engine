# For dealing with external subscriptions
class SubscriptionsController < ApplicationController
  def new

  end

  def create
    if request.env["omniauth.auth"]
      auth_create(request.env["omniauth.auth"])
    elsif params[:refeeder_id]
      refeed_create(params[:refeeder_id], params[:poster_id])
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

  def auth_create(auth_response)
    Subscription.create_with_omniauth(auth_response, current_user)
    notice = "Your account has been linked with #{auth_response["provider"]}"
    if current_user.subscribed_to_all_services? || authorized_from_dashboard
      redirect_to dashboard_path, notice: notice
    else
      redirect_to new_subscription_path, notice: notice
    end
  end

  def refeed_create(refeeder_id, poster_id)
    poster = User.find(poster_id)
    Subscription.create_with_refeed(poster_id, refeeder_id)
    redirect_to :back, notice: "You are now refeeding #{poster.display_name}"
  end

end
