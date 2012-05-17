class AuthenticationsController < ApplicationController
  def new
  end

  def destroy
    authentication = current_user.authentications.where(id: params[:id]).first

    if authentication.destroy
      redirect_to edit_user_registration_path, notice: "Your #{authentication.provider.capitalize} account has been unlinked."
    else
      redirect_to edit_user_registration_path, notice: "There was an issue in unlinking your account."
    end
  end
end
