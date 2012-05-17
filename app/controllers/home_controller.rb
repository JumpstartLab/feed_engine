# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    @posts = Item.all_items_sorted_posts
    # redirect_to dashboard_path if current_user
  end
end
