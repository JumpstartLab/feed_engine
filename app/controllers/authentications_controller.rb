class AuthenticationsController < ApplicationController

  def show
    @user = current_user
  end
end
