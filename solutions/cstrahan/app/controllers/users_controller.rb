class UsersController < ApplicationController
  before_filter :require_authentication_for_private_accounts
  respond_to :html, :json

  def show
  end

  def edit
    @user = current_user
  end

  def following
  end

  def followers
  end

  def refeeds
  end

  private

  def require_authentication_for_private_accounts
    if current_user.blank?
      if user.private
        redirect_to new_user_session_path, notice: "The previous account is only available to signed in users"
      end
    end
  end

end
