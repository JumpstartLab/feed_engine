class Api::V1::FeedsController < Api::V1::BaseController
  def show
    user = User.find(params[:user_id])
    @stream_items = user.stream_items.all
    respond_with(@stream_items)
  end
end
