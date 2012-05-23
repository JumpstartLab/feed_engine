class SignupLinkInstagramController < ApplicationController
  def show
    session[:next_auth_path] = dashboard_path
  end

  def skip
    flash[:notice] = "You can link your Instagram account later!"
    redirect_to dashboard_path
  end
end
