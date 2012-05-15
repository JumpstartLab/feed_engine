class Api::FeedsController < Api::BaseController
  def index
  end

  def show
    @user = current_user
  end
end
