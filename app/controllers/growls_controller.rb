class GrowlsController < ApplicationController
  def index
    @growls = Growl.order("created_at DESC").page(params[:page])
  end
end
