# The controller for a user - creating and editing accounts and showing posts
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = Kaminari.paginate_array(@user.sorted_posts).page(params[:page]).per(12)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.send_welcome_email
      redirect_to dashboard_path, notice: "Thank you for signing up!"
    else
      @password, @password_confirmation = params[:user][:password], params[:user][:password_confirmation]
      render "new"
    end
  end
end
