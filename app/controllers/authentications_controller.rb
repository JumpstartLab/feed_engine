class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def destroy
    authentication = current_user.authentications.where(id: params[:id]).first
    @growl = current_user.growls.build
    @type = "Service"
    flash[:notice] = "Your #{authentication.provider.capitalize} account
         has been unlinked." if authentication.try(:destroy)
    render "dashboards/show"
  end

end