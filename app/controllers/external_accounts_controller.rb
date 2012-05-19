class ExternalAccountsController < ApplicationController
  before_filter :authenticate_user!, :only => :index 
  
  def index
  end

  def skip_link
    redirect_to dashboard_url
    flash[:notice] = "You can link your account later!"
  end
end
