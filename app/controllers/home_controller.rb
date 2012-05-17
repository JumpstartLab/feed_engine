# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    @posts = Kaminari.paginate_array(
               Item.all_items_sorted_posts
             ).page(params[:page]).per(20)
  end
end
