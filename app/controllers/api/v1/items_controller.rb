# Versioning APIs will help us make changes in the future
class Api::V1::ItemsController < ApplicationController
  respond_to :json

  before_filter :validate_request!

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
    if authorized?(params) && post_type = extract_post_class_from(params)
      @post = build_post_from(params, post_type)

      if @post.save
        success(:created, "#{post_type} created successfully")
      else
        error(:unprocessable_entity, "#{post_type} could not be created")
      end
    else
      error(:unauthorized)
    end
  end

  private

  def extract_post_class_from(params)
    params[:post][:type].camelcase.safe_constantize if params[:post]
  end

  def build_post_from(params, post_type)
    post_attributes = params[:post].tap { |param| param.delete(:type) }
    display_name = params[:display_name]
    post_attributes[:poster_id] = User.find_by_display_name(display_name).id

    post_type.new(post_attributes)
  end

  def error(type, msg = nil)
    respond_with({ :error    => "#{ msg || type }" }.to_json,
                   :status   => type,
                   :location => '')
  end

  def success(type, msg = nil)
    respond_with({ :success  => "#{ msg || type }" }.to_json,
                   :status   => type,
                   :location => '')
  end

  def authorized?(params)
    key, display_name = params[:api_key], params[:display_name]
    user = User.find_by_api_key(key)
    user && user.display_name == display_name
  end

  def validate_request!
    post_type = params[:post][:type].camelcase.safe_constantize if params[:post]
    error(:unprocessable_entity) unless post_type
  end
end
