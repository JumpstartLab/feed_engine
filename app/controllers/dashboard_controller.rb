class DashboardController < ApplicationController
  def show
    @text_item = TextItem.new
    @text_items = TextItem.all
  end
end
