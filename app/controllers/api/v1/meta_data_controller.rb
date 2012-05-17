class Api::V1::MetaDataController < Api::V1::ApiController

  def create
    render :json => MetaData.find_link_data(params[:url])
  end

end
