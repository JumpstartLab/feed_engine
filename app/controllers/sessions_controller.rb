# The controller for logging in and out
class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email]) || User.new
    if @user.id && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      add_point(session[:point_pending_for]) if session[:point_pending_for]
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

end
