class RiverController < ApplicationController
  def show
    @stream_items = StreamItem.where(refeed: false).order("created_at DESC").limit(5)
    @new_spawns = User.new_spawns
    current_user
    render :template => "devise/sessions/new"
  end
end
