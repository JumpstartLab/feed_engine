class TwittersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  end

  def skip_step
    redirect_to dashboard_path, :notice => "You can sign up with Twitter by visiting dashboard"
  end
end
