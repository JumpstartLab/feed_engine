class Api::FeedsController < ApiController
  def show
    @feed = Feed.find_by_name(params[:id])
  end
end
