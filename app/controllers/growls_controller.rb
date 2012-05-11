class GrowlsController < ApplicationController
  def show
    subdomain = request.subdomain
    @user = User.where{display_name.matches subdomain}.first
    if @user
      @growls = @user.growls.by_type(params[:type]).by_date.page(params[:page])
    end
  end

  def create
    @type = params[:growl][:type]
    @growl = current_user.relation_for(@type).new(params[:growl])
    if @growl.save
      flash[:notice] = "Your #{@type.downcase} has been created."
      redirect_to dashboard_path
    else
      @growl = @growl.becomes(Growl)
      render "dashboards/show"
    end
  end
end
