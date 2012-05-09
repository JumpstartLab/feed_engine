class GrowlsController < ApplicationController
  def index
    @growls = Growl.order("created_at DESC").page(params[:page])
  end

  def show
    @growls = Growl.find_by_subdomain!(request.subdomain)
  end
end
