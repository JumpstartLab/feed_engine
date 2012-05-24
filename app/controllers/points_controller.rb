class PointsController < ApplicationController

  def create
    if giver_id.blank?
      set_session_variables
      redirect_to new_user_session_path
      flash[:notice] = "Please sign in first before giving points"
    else
      @point = Point.create(post_id: post_id,
                            receiver_id: receiver_id,
                            giver_id: giver_id)
      if @point.save
        flash[:notice] = "Point Added!"
        redirect_to :back
      else
        flash[:notice] = "You can only point once!"
        redirect_to :back
      end
    end
  end

  private

  def set_session_variables
    session[:post_id] = post_id
    session[:receiver_id] = receiver_id
    session[:page_before_sign_in] = page_before_sign_in
  end

  def post_id
    params[:post_id]
  end

  def receiver_id
    params[:receiver_id]
  end

  def giver_id
    params[:giver_id]
  end

  def page_before_sign_in
    params[:page_before_sign_in]
  end
end
