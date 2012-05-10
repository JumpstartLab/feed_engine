class HomeController < ApplicationController
  def index
    # if logged_in
    #   redirect_to posts_path
    # end
    if current_user
      @user = current_user
      @posts = Kaminari.paginate_array(@user.sorted_posts).page(params[:page]).per(12)
    end
  end
end
