class RiverController < ApplicationController
  def show
    @stream_items = StreamItem.where(refeed: false).order("created_at DESC").limit(5)
    @items = @stream_items.collect { |i| i.streamable }
    current_user
    render :template => "devise/sessions/new"
  end
end
