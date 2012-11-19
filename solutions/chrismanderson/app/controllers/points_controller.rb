class PointsController < ApplicationController
  def create
    if current_user
      @point = Point.new(user: current_user, pointable_id: params[:item_id], pointable_type: params[:item_type])
      if @point.save
        session[:point_for] = nil
        redirect_to request.referrer, :notice => "You made some points. Rock on!"
      else
        redirect_to request.referrer, :alert => "You've already pointed this item"
      end
    else
      prep_for_point_in_session
    end
  end

  private

  def prep_for_point_in_session
    session[:point_for] = params[:item_id]
    session[:point_for_type] = params[:item_type]
    redirect_to login_url(:subdomain => false), :alert => "Please log in or sign up first."
  end
end
