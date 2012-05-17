# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    @posts = User.all.collect { |user| user.items }.flatten(1)
    redirect_to dashboard_path if current_user
  end
end
