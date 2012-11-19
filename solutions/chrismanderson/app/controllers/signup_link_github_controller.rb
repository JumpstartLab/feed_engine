class SignupLinkGithubController < ApplicationController
  before_filter :authenticate_user!

  def show
    session[:next_auth_path] = signup_link_instagram_path
  end

  def skip
    flash[:notice] = "You can link your Github account later!"
    redirect_to signup_link_instagram_path
  end
end
