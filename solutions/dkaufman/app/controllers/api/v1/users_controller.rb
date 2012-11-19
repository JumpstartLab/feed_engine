class Api::V1::UsersController < Api::V1::ApiController

  def twitter
    @accounts = TwitterAccount.all
  end

  def github
    @accounts = GithubAccount.all
  end

  def instagram
    @accounts = InstagramAccount.all
  end
end
