class HomeController < ApplicationController
  def index
    # if logged_in
    #   redirect_to posts_path
    # end
    redirect_to user_path(current_user) if current_user
  end
end
