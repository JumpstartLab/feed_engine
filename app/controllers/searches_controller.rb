class SearchesController < ApplicationController
  def show
    redirect_to "http://#{params[:display_name]}.#{request.domain}"
  end

  def display_names
    search_term = params["term"]
    query = "display_name LIKE ?"
    users = User.order(:display_name).where(query, "#{search_term}%")
    render json: users.map(&:display_name)
  end
end
