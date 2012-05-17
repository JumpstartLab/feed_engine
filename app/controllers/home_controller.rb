# The controller for the home that is the splash page
class HomeController < ApplicationController
  def index
    @items = Item.all_items_sorted
    # redirect_to dashboard_path if current_user
  end
end
