class Api::V1::UsersController < Api::V1::BaseController
  # respond_to :json

  def index
    @accounts = TwitterAccount.all
  end

end
