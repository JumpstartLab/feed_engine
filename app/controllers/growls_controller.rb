class GrowlsController < ApplicationController
  def index
    @growls = Growl.order("created_at DESC").page(params[:page])
  end

  def show
    subdomain = request.subdomain
    @user = User.where{username.matches subdomain}.first
    @growls = Growl.for_user(subdomain)
  end
end
