class PagesController < ApplicationController
  def home
    redirect_to dashboard_path, :flash => flash if current_user
    @growls = Growl.by_date.page(params[:page])
    render :layout => "layouts/home"
  end
end
