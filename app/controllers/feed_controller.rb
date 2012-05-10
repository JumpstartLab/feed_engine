class FeedController < ApplicationController
  def show
    subdomain_username = request.subdomain
    if current_user 
      @stream_items = current_user.stream_items.order("created_at DESC").page(params[:page]).per(12)
      @items = StreamItem.translate_batch(@stream_items)
    elsif request.subdomain.present?
      user = User.find_by_display_name("#{subdomain_username}")
      @stream_items = user.stream_items.order("created_at DESC").page(params[:page]).per(12)
      @items = StreamItem.translate_batch(@stream_items)
    else
      redirect_to 'google.com'
    end
  end
end
