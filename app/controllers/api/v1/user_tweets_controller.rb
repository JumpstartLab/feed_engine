class Api::V1::UserTweetsController < Api::V1::BaseController
  # respond_to :json

  before_filter :verify_twitter_account

  def create
    tweets = JSON.parse(params["tweets"])

    tweets.each do |tweet|
      @twitter_account.user.tweets.create(link: tweet["link"], comment: tweet["comment"])
      @twitter_account.update_last_status_id(tweet["status_id"])
    end
    render :json => true, :status => 201
  end

  private

  def verify_twitter_account
    @twitter_account = TwitterAccount.where(nickname: params["nickname"]).first
    unless @twitter_account
      render :json => "Twitter account can not be found.", :status => 500
    end
  end

end
