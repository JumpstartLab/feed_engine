class SessionsController < ApplicationController
  def new
  end

  def create
    post_id = session[:visitor_post]
    session[:visitor_post] = nil
    user_info = params[:data]
    if @user = login(user_info[:email], user_info[:password])
      if post_id
        Point.create(user_id: @user.id, post_id: post_id)
      end
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
