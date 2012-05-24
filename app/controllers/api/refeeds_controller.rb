class Api::RefeedsController < Api::BaseController
  def create
    refeeder = User.find_by_authentication_token(params[:token])
    author = User.find_by_display_name(params[:display_name])
    stream_item = author.stream_items.find(params[:id])
    item = stream_item.streamable
    refeed = refeeder.stream_items.new(streamable_id: item.id,
                                       streamable_type: item.class.name,
                                       original_author_id: item.user.id,
                                       refeed: true)
    if refeed.save
      if request.xhr?
        Pusher["#{refeed.author.display_name}"].trigger('greet', {:author => refeed.author.display_name, :refeed => refeeder.display_name } )
      end
      respond_with(refeed, :status => :created,
                           :location => api_item_path(refeeder, item))
    else
      render :json => {errors: [refeed.errors]}, :status => :bad_request
    end
  end
end
