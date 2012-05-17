# Versioning APIs will help us make changes in the future
class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    unless @user = User.find_by_display_name(params[:display_name])
      render :json => {
             error: "user #{params[:display_name]} not found"
             },
             :status => :not_found
    end

    @items = Item.find_all_by_poster_id(@user.id)

    respond_with do |format|
      format.json
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find_by_display_name(params[:display_name])

    unless @user
      render :json => {
             error: "user #{params[:display_name]} not found"
             },
             :status => :not_found
    end

    respond_with do |format|
      format.json
    end
  end

  def create
    unless authorized?(params[:api_key], params[:display_name])
      respond_with({ :error => 'unauthorized' }.to_json,
                   :status => :unauthorized,
                   :location => '')
    end
  end

  private

  def authorized?(key, name)
    user = User.find_by_api_key(key)
    user && user.display_name == name
  end
end
