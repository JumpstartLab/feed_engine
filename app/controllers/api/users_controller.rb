class Api::UsersController < ApplicationController
  def show
    @user = User.find_by_display_name(params[:display_name])
    unless @user
      render :json => {
             error: "user #{params[:display_name]} not found"
             },
             :status => :not_found
    end
  end
end
