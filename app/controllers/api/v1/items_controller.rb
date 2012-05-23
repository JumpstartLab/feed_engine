# Versioning APIs will help us make changes in the future
class Api::V1::ItemsController < ApplicationController
  respond_to :json

  before_filter :validate_request!, :except => [:index, :show, :refeed]
  before_filter :validate_token!, :except => [:index, :show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    error(:not_found, exception.message)
  end

  rescue_from Item::NotRefeedable do |exception|
    error(:conflict, exception.message)
  end

  def index
    @user = User.find_by_display_name(params[:display_name])
    @items = Item.find_all_by_poster_id(@user.id)
  end

  def show
    @user = User.find_by_display_name!(params[:display_name])
    @item = Item.find(params[:id])
  end

  def create
    if authorized?(params) && post_type = extract_post_class_from(params)
      @user = User.find_by_display_name(params[:display_name])
      @post = build_post_from(params, post_type)

      if @post.save
        success(:created, "#{post_type} created successfully", @post)
      else
        error(:unprocessable_entity, "#{post_type} could not be created")
      end
    else
      error(:unauthorized)
    end
  end

  def refeed
    item = Item.find(params[:item_id])
    user = User.find_by_api_key!(params[:api_key])
    item.refeed_for(user)
    success(:created, "Refeed created successfully")
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
    render :json => { :error => "#{ msg || type }"}, :status => type
  end

  def success(type, msg = nil, post = nil)
    @item = post
    render :json => { :error => "#{ msg || type }"}, :status => type
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

  def validate_token!
    user = User.find_by_api_key(params[:api_key])
    error(:forbidden) unless user
  end
end
