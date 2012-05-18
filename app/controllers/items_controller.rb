class ItemsController < ApplicationController

  def update
    item = Item.find(params[:id])
    session[:return_to] = request.referrer
    if current_user
      if params[:points] && item.poster_id != current_user.id
        item.post.increase_point_count
        params[:points] = nil
      end
      redirect_to session[:return_to]
    else
      session[:point_pending_for] = item.id
      redirect_to login_url(:subdomain => false)
    end
  end
end
