class PagesController < ApplicationController
  def home
    redirect_to dashboard_path, :flash => flash if current_user
    @growls = Growl.order(:original_created_at).page(params[:page])
  end
end
