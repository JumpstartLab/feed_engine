class ApplicationController < ActionController::Base

  private

  def load_user
    @user = User.find_by_subdomain!(request.subdomain)
  end
end
