class LinkItemsController < ApplicationController
  def new
    @link_item = LinkItem.new
  end
end
