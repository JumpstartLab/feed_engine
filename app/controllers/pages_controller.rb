class PagesController < ApplicationController
  def home
    return redirect_to dashboard_path, :flash => flash if current_user
    @growls = Growl.by_date.where_original.page(params[:page])
    render :layout => "layouts/home"
  end
end
