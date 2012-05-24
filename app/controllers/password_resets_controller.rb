# For resetting passwords
class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.create_password_reset if user
    notice = "Email sent with password reset instructions."
    redirect_to root_url, :notice => notice
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 12.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset expired."
    elsif @user.update_attributes(params[:user])
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
