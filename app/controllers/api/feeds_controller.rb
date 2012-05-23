class Api::FeedsController < Api::BaseController
  skip_before_filter :authenticate_user, only: [:show]

  def index
  end

  def show
    @user = User.find_by_display_name(params[:id])
  end
end
