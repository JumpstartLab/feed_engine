class ItemsController < ApplicationController

  def update
    item = Item.find(params[:id])
    session[:return_to] = request.referrer
    if params[:points] && item.poster_id != current_user.id
      item.post.increase_point_count
    end
    redirect_to session[:return_to]
  end
end
