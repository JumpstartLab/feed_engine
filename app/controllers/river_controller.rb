class RiverController < ApplicationController
  def show
    @stream_items = StreamItem.order("created_at DESC").limit(5)
    @items = @stream_items.collect { |i| i.streamable }
    render :template => "devise/sessions/new"

  end
end
