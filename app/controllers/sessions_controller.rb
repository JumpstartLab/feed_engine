class SessionsController < ApplicationController
  def new
  end

  def create
    #json_user = params[:data][:user]
    @user = login(params[:email], params[:password])
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

  def destroy
    logout
  end
end
