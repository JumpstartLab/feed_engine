class Api::V1::MetaDataController < ApplicationController
    before_filter :authenticate_user

  def create
    render :json => MetaData.find_link_data(params[:url])
  end

  private

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      render :json => "Token is invalid.".to_json, status: 401
    end
  end

  def current_user
    @current_user
  end
end
