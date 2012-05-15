class Api::FeedsController < ApiController
  def index
    @user = User.find_by_display_name(params[:id])
  end

  def show
    @user = User.find_by_display_name(params[:id])
  end
end
