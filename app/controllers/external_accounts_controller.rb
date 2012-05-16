class ExternalAccountsController < ApplicationController
  def index
  end

  def skip_link
    redirect_to dashboard_url
    flash[:notice] = "You can link your account later!"
  end
end
