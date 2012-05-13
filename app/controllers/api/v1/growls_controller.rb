class Api::V1::GrowlsController < ApplicationController
  #before_filter :authenticate_user!
  respond_to :json

  def index
    @user = User.where(display_name: params[:display_name]).first
    @growls = @user.growls
    respond_with(@growls)
  end

  def create
    @user = User.where(display_name: params[:display_name]).first
    @growl = @user.relation_for(@type).new(params[:body])
    # @growl.build_meta_data(params[:meta_data]) if params[:meta_data]
    if @growl.save
      render :json => @growl, :status => 201
    else
      render :json => @growl.errors
    end
  end
end

