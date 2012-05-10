class GrowlsController < ApplicationController
  def show
    subdomain = request.subdomain
    @user = User.where{display_name.matches subdomain}.first

    @growls = @user.growls.by_date.page(params[:page]) if @user
  end
end
