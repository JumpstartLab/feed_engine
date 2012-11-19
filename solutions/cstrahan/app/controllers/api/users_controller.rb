class Api::UsersController < Api::BaseController
  skip_before_filter :authenticate_user
  before_filter :require_master_token

  def index
    @users = User.all
  end
end
