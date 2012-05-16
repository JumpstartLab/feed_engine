class Api::ItemsController < ApplicationController
  respond_to :json 
  def show
    @item = Item.find(params[:id])
    @user = User.find_by_display_name(params[:display_name])
    unless @user
      render :json => { error: "user #{params[:display_name]} not found" }, :status => :not_found
    end
    respond_with do |format|
      format.json
    end
  end
end
