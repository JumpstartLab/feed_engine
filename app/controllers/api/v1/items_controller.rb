# Versioning APIs will help us make changes in the future
class Api::V1::ItemsController < ApplicationController
  respond_to :json

  before_filter :valid_request?

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
    key, name = params[:api_key], params[:display_name]
    post_type = params[:post][:type].camelcase.safe_constantize if params[:post]

    if authorized?(key, name) && post_type
      @post = post_type.create(params[:post])
    else
      error(:unauthorized)
      #{"post"=>{
      #"type"=>"message", "body"=>"Lovebuckets!", "api_key"=>"5f359492d94a630cab93941b7762b137"}, 
      #"format"=>"json", "display_name"=>"voluptate-numquam-411909", "controller"=>"api/v1/items", "action"=>"create"}
    end
  end

  private

  def error(type)
    respond_with({ :error => type.to_s }.to_json,
                 :status => type,
                 :location => '')
  end

  def authorized?(key, name)
    user = User.find_by_api_key(key)
    user && user.display_name == name
  end

  def validate_request!
    post_type = params[:post][:type].camelcase.safe_constantize if params[:post]
    error(:unprocessable_entity) unless post_type
  end
end
