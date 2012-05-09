class Api::V1::ImagesController < ActionController::Base
  #before_filter :authenticate_user!
  respond_to :json
  def index
    @images = Image.all
    respond_with(@images)
  end

end