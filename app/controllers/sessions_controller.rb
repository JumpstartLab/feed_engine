# The controller for logging in and out
class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email]) || User.new
    if @user.id && @user.authenticate(params[:password])
      create_session_with_points_check
      redirect_to dashboard_path, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  private

  def create_session_with_points_check
    create_user_session
    add_point(session[:point_pending_for]) if session[:point_pending_for]
  end
end
