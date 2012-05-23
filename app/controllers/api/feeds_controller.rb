class Api::FeedsController < Api::BaseController

  def index
  end

  def show
    @user = User.find_by_display_name(params[:id])
  end
end
