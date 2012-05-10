class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_display_name(request.subdomain)
    # The notice does not presently appear on the homepage after redirect, remove this when it does.
    redirect_to(root_url(:host => request.domain), :notice => "User #{request.subdomain} not found.") unless @user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.send_welcome_email
      redirect_to dashboard_path, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
