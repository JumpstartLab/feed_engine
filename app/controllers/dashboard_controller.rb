class DashboardController < ApplicationController
  def show
    @text_item = TextItem.new
    @text_items = TextItem.all
    @link_items = LinkItem.all
  end
end
