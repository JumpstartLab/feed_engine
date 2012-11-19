class HomeController < ApplicationController
  def index
    if current_user
      redirect_to dashboard_path
    end
  end

  def profile
    @post = current_user.posts.new if current_user
  end
end
