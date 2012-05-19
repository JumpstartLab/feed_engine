class SignupLinkGithubController < ApplicationController
  def show
    session[:next_auth_path] = dashboard_path
  end
end
