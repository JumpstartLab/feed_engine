class Api::V1::UsersController < Api::V1::ApiController

  def twitter
    @accounts = TwitterAccount.all
  end

end
