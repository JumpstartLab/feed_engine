class GrowlsController < ApplicationController
  def show
    subdomain = request.subdomain
    @user = User.where{username.matches subdomain}.first
    @growls = @user.growls
  end
end
