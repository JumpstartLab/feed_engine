class ItemsController < ApplicationController
  respond_to :xml, :json

  def index
    @posts = User.where(display_name: params[:user_display_name]).first.posts.page(params[:page])
  end
end
