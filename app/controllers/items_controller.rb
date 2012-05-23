# handles adding points to posts
class ItemsController < ApplicationController
  before_filter :set_return_session, only: :update

  def update
    @item = Item.find(params[:id])
    if current_user
      try_to_add_point
      redirect_to session[:return_to]
    else
      session[:point_pending_for] = @item.id
      redirect_to login_url(:subdomain => false)
    end
  end

  def refeed
    item = Item.find(params[:id])

    if item.refeed_for(current_user)
      redirect_to :back
    else
      render :template => 'home/index'
    end
  end

  private

  def try_to_add_point
    if params[:points] && @item.poster_id != current_user.id
      @item.post.increase_point_count
    end
  end
end
