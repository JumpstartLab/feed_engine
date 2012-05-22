class GrowlsController < ApplicationController

  # XXX SHOULD BE MOVED TO A FEEDS CONTROLLER
  def index
    subdomain = request.subdomain
    @user = User.where{display_name.matches subdomain}.first
    @growls = @user.get_growls(params[:type]).page(params[:page])
  end

  def create
    @growl = current_user.relation_for(params[:growl][:type]).new(params[:growl])
    @growl.build_meta_data(params[:meta_data]) if params[:meta_data]
    if @growl.save
      flash[:notice] = "Your #{@growl.type.downcase} has been created."
      redirect_to dashboard_path
    else
      @growl = @growl.becomes(Growl)
      render "dashboards/show"
    end
  end

end
