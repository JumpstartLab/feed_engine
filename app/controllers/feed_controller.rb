class FeedController < ApplicationController
  def show
    subdomain_username = request.subdomain
    user = User.where("display_name LIKE ?", subdomain_username).first

    if user
      @stream_items = user.stream_items.includes(:user, :streamable).includes(:user).order("created_at DESC").page(params[:page]).per(12)
      @feed_owner = user
      respond_to do |format|
        format.html
        format.js
      end
    elsif current_user
      redirect_to '/dashboard'
    else
      redirect_to root_url(:subdomain => false)
    end
  end
end
