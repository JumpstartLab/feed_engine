class ItemsController < ApplicationController
  respond_to :xml, :json

  def index
    @posts = user.feed.page(params[:page])
  end
end
