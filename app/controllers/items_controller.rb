# handles adding points to posts
class ItemsController < ApplicationController
  before_filter :set_return_session, only: :update

  def update
    @item = Item.find(params[:id])
    if current_user
      try_to_add_point
    else
      prompt_login_with_pending_point
    end
  end

  private

  def try_to_add_point
    if params[:points] && @item.poster_id != current_user.id
      @item.post.increase_point_count
      redirect_to session[:return_to]
    else
      notice = "Points! were not added, an unknown error occurred"
      redirect_to session[:return_to], notice: notice
    end
  end

  def prompt_login_with_pending_point
    session[:point_pending_for] = @item.id
    notice = "You must be logged in to give Points! " +
      "<a href='#{session[:return_to]}'>No thanks, take me back</a>".html_safe
    redirect_to login_url(:subdomain => false), notice: notice
  end
end
