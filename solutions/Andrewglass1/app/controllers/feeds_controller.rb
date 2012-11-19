class FeedsController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = params[:id]
    @users = User.all
    @feed = Feed.find_by_name(request.subdomain)
  end
end
