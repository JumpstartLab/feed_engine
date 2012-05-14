class StaticPagesController < ApplicationController

  before_filter :route_to_dashboard_if_logged_in

  def show
  end

  def route_to_dashboard_if_logged_in
    redirect_to dashboard_url(subdomain: false) if user_signed_in?
  end
end
