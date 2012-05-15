class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @text_item = TextItem.new
    @link_item = LinkItem.new
    @image_item = ImageItem.new
  end
end
