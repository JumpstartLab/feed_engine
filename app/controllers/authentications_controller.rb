class AuthenticationsController < ApplicationController

  def show
  end

  def new
    omniauth = request.env["omniauth.auth"]
    auth = current_user.authentications.find_or_initialize_by_provider(omniauth["provider"])
    if auth.create_with_omniauth(omniauth)
      redirect_to dashboard_url(subdomain: false),
        notice: "#{omniauth["provider"].capitalize} account connected!"
    else
      redirect_to dashboard_url(subdomain: false),
        notice: "Something went wrong connecting to #{omniauth["provider"].capitalize}! Please try again!"
    end
  end

  def skip
    redirect_to dashboard_url(subdomain: false), 
      notice: "You can link your account at any time by clicking on the buttons to the right!"
  end

  def destroy
    provider_name = params[:id]
    current_user.remove_auth_for(provider_name)
    flash[:notice] = "Successfully Destroyed"
    redirect_to dashboard_path
  end
end
