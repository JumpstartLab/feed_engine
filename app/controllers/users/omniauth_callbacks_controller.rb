class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_omniauth_data

  def twitter
    response = Authentication.add_twitter(current_user, @data)
    redirect_to new_authentication_path, :notice => "Twitter account successfully added."
  end

  def github
    response = Authentication.add_github(current_user, @data)
    redirect_to new_authentication_path, :notice => "Github account successfully added."
  end

  def instagram
    response = Authentication.add_instagram(current_user, @data)
    if response
      message = "Account successfully added."
    else
      message = "There was an error adding your instagram account"
    end
    redirect_to new_authentication_path, :notice => message
  end

  private

  def get_omniauth_data
    @data = request.env["omniauth.auth"]
  end

end

