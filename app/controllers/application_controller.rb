class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def load_user
    @user = User.find_by_subdomain!(request.subdomain)
  end
end
