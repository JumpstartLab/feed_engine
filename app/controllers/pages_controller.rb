class PagesController < ApplicationController
  def home
    redirect_to dashboard_path, :flash => flash if current_user
  end
end
