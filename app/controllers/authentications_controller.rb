class AuthenticationsController < ApplicationController

  def show
  end

  def skip
    redirect_to dashboard_url(subdomain: false), 
      notice: "You can link your account at any time by clicking on the buttons to the right!"
  end
end
