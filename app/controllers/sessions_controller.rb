class SessionsController < ApplicationController
  def new
  end

  def create
    user_info = params[:data] || params
    @user = login(user_info[:email], user_info[:password])
    if @user
      render "create",
      :status => :ok,
      :handlers => [:jbuilder]
    else
      render "login_failed",
      :status => :unauthorized,
      text: "Login unsuccessful. Please check your username and password and try again.",
      :handlers => [:jbuilder]
    end
  end

  def user
    @user = current_user
  end

  def destroy
    logout
    render "logout", status: :ok, :handlers => [:jbuilder]
  end
end
