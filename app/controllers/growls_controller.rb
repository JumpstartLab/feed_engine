class GrowlsController < ApplicationController
  before_filter:require_sign_in, only: [:points, :create]

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
      @type = params[:growl][:type]
      @growl = @growl.becomes(Growl)
      render "dashboards/show"
    end
  end

  def points
    growl = Growl.find(params[:id])
    growl.increment!(:points)
    redirect_to root_path
  end

  private

  def require_sign_in
    unless current_user
      redirect_to "http://#{request.domain}#{home_path}"
      session[:growl_needing_point] = params[:id]
      flash[:notice] = "Login or sign up first please."
    end
  end
end
