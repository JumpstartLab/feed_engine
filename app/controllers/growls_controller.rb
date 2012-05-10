class GrowlsController < ApplicationController
  def show
    subdomain = request.subdomain
    @user = User.where{username.matches subdomain}.first
    @growls = Growl.for_user(subdomain)
  end
end
