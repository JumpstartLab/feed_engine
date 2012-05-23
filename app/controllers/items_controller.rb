# handles adding points to posts
class ItemsController < ApplicationController
  before_filter :set_return_session, only: [:show, :update]
  after_filter :expire_fragment_caches, only: [:update, :refeed]

  def update
    @item = Item.find(params[:id])
    if current_user
      add_point(@item.id) if params[:points]
      redirect_to :back
    else
      session[:point_pending_for] = @item.id
      redirect_to login_url(:subdomain => false)
    end
  end

  def refeed
    @item = Item.find(params[:id])

    if @item.refeed_for(current_user)
      redirect_to :back
    else
      render :template => 'home/index'
    end
  end

  private

  def expire_fragment_caches
    expire_fragment "post_#{@item.id}"
  end
end
