class AuthenticationsController < ApplicationController

  def show
  end

  def new
    omniauth = request.env["omniauth.auth"]
    auth = current_user.authentications.find_or_initialize_by_provider(omniauth["provider"])
    if auth.create_with_omniauth(omniauth)
      if omniauth["provider"] == "twitter"
        redirect_to github_sign_in_page
      elsif omniauth["provider"] == "github"
        redirect_to instagram_sign_in_page
      elsif omniauth["provider"] == "instagram"
        redirect_to dashboard_path,
        notice: "Welcome! You have signed up successfully."
      end
      flash[:notice] = "#{omniauth["provider"].capitalize} account connected!"
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

  private

  def github_sign_in_page
    "/user_signup_steps/github"
  end

  def instagram_sign_in_page
    "/user_signup_steps/instagram"
  end
end
