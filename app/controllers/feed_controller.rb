class FeedController < ApplicationController
  def show
    subdomain_username = request.subdomain
    user = User.find_by_display_name("#{subdomain_username}")
    if user
      @stream_items = user.stream_items.order("created_at DESC").page(params[:page]).per(12)
      @items = @stream_items.collect { |i| i.streamable}
      @feed_owner = user
    elsif current_user
      redirect_to '/dashboard'
    else
      redirect_to '/login'
    end
  end
end
