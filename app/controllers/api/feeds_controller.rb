class Api::FeedsController < Api::BaseController
  def index
  end

  def show
    @user = User.first
  end
end
