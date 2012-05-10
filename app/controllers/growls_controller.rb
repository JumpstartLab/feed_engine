class GrowlsController < ApplicationController
  def show
    subdomain = request.subdomain
    @user = User.where{username.matches subdomain}.first
    if @user
      @growls = @user.growls.by_type(params[:type]).by_date.page(params[:page])
    end
  end
end
