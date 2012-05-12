class SubscriptionsController < ApplicationController
  def new

  end

  def create
    Subscription.create_with_omniauth(request.env["omniauth.auth"], current_user)
    notice = "Your account has been linked with twitter"
    redirect_to dashboard_path, notice: notice
  end


end
