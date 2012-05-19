class SignupLinkTwitterController < ApplicationController
  def show
    session[:next_auth_path] = signup_link_github_path
  end
end
