class Api::V1::MetaDataController < ApplicationController
    before_filter :authenticate_user

  def create
    render :json => MetaData.find_link_data(params[:url])
  end

  private

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    render :json => "Token is invalid.".to_json unless @current_user
  end

  def current_user
    @current_user
  end
end
