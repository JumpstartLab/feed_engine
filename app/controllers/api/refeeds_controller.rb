class Api::RefeedsController < Api::BaseController
  def create
    refeeder = User.find_by_authentication_token(params[:token])
    author = User.find_by_display_name(params[:display_name])
    item = author.stream_items.find_by_streamable_id(params[:id]).streamable 
    refeed = refeeder.stream_items.new(streamable_id: item.id,
                                       streamable_type: item.class.name,
                                       refeed: true)
    if refeed.save
      respond_with(refeed, :status => :created,
                           :location => api_item_path(refeeder, item))
    else
      render :json => {errors: [refeed.errors]}, :status => :bad_request
    end
  end
end
