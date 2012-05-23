class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def destroy
    authentication = current_user.authentications.where(id: params[:id]).first
    @growl = current_user.growls.build
    @type = "Service"

    if authentication.try(:destroy)
      flash[:notice] = "Your #{authentication.provider.capitalize} account
         has been unlinked."
      render "dashboards/show"
    else
      flash[:notice] = "There was an issue in unlinking your account."
      render "dashboards/show"
    end
  end
end
