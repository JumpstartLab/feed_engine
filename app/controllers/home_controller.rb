# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    instantiate_posts
    @user = User.new
    @posts = Kaminari.paginate_array(
               Item.all_items_sorted_posts
             ).page(params[:page]).per(12)
  end
end
