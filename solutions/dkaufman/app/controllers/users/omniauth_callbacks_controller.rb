class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_omniauth_data
  before_filter :build_dashboard_variables

  def twitter
    response = Authentication.add_twitter(current_user, @data)
    flash[:notice] = "Twitter account successfully added."
    if session[:registration].present?
      redirect_to new_authentication_path
    else
      render "dashboards/show"
    end
  end

  def github
    response = Authentication.add_github(current_user, @data)
    flash[:notice] = "Github account successfully added."
    if session[:registration].present?
      redirect_to new_authentication_path
    else
      render "dashboards/show"
    end
  end

  def instagram
    response = Authentication.add_instagram(current_user, @data)
    flash[:notice] = "Instagram account successfully added."
    if session[:registration].present?
      redirect_to new_authentication_path
    else
      render "dashboards/show"
    end
  end

  private

  def get_omniauth_data
    @data = request.env["omniauth.auth"]
  end

  def build_dashboard_variables
    @growl = current_user.growls.build
    @type = "Service"
  end

end

