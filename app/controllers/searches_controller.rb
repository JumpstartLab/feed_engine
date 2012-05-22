class SearchesController < ApplicationController
  def show
    redirect_to "http://#{params[:display_name]}.#{request.domain}" 
  end

  def display_names
    search_term = params[:term]
    users = User.order(:display_name).where{ display_name.match search_term }
    render json: users.map(&:display_name)
  end
end
