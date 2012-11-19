class RiverController < ApplicationController
  def show
    @stream_items = StreamItem.includes(:user, :streamable).where(refeed: false).order("created_at DESC").limit(5)
    current_user
    @new_spawns = User.new_spawns
    render :template => "devise/sessions/new"
  end
end
