class Api::V1::MetaDataController < ApplicationController
  def create
    render :json => MetaData.find_link_data(params[:url])
  end
end
