class Api::UsersController < ApplicationController

  def index
    query = "#{params[:q]}%"
    users = User.where("display_name LIKE ?", query).limit(5)
    users = users.map(&:decorate)
    render :json => users
  end

end
