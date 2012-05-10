class FeedController < ApplicationController
  def show
    @text_items = TextItem.order("created_at DESC").page(params[:page]).per(12)
    @link_items = LinkItem.order("created_at DESC").all

  end
end
