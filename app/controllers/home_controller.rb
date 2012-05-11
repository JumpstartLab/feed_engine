# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @posts = Kaminari.paginate_array(
                          @user.sorted_posts
                        ).page(params[:page]).per(12)
    end
    redirect_to dashboard_path if current_user
  end
end
