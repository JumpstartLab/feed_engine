class DashboardController < ApplicationController
  before_filter :authenticate_user!, :exit_subdomain
  def show
    @text_item = TextItem.new
    @link_item = LinkItem.new
    @image_item = ImageItem.new
  end
  
  private
  
  def exit_subdomain
    if !request.subdomain.blank?
      redirect_to dashboard_url(subdomain: false) and return
    end
  end
end
