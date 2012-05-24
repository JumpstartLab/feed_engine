class TwittersController < ApplicationController
  before_filter :authenticate_user!

  def show
    session[:authentication_workflow] = socialmedia_path
  end

  def skip_step
    redirect_to dashboard_path,
    :notice => t(:social_media_invitation)
  end
end
