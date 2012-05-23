class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_omniauth_data
  before_filter :build_dashboard_variables

  def twitter
    response = Authentication.add_twitter(current_user, @data)
    flash[:notice] = "Twitter account successfully added."
    render "dashboards/show"
  end

  def github
    response = Authentication.add_github(current_user, @data)
    flash[:notice] = "Github account successfully added."
    render "dashboards/show"
  end

  def instagram
    response = Authentication.add_instagram(current_user, @data)

    if response
      flash[:notice] = "Account successfully added."
    else
      flash[:notice] = "There was an error adding your instagram account"
    end
    render "dashboards/show"
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

