class Api::V1::GrowlsController < ApplicationController
  #before_filter :authenticate_user!
  respond_to :json

  def index
    @user = User.where(display_name: params[:user]).first
    @growls = user.growls
    respond_with(@growls)
  end

  def create
    @user = User.where(display_name: params[:display_name]).first
    @growl = current_user.relation_for(@type).new(params[:growl])
    @growl.build_meta_data(params[:meta_data]) if params[:meta_data]    
  end
end

