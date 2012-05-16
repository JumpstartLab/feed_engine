class Api::V1::UserTweetsController < Api::V1::BaseController
  # respond_to :json

  def create
    unless twitter_account = TwitterAccount.where(nickname: params["nickname"]).first
      render :json => "Twitter account can not be found.", :status => 500
      return
    end

    tweets = JSON.parse(params["tweets"])

    tweets.each do |tweet|
      twitter_account.user.tweets.create(link: tweet["link"], comment: tweet["comment"])

      if twitter_account.last_status_id.to_f < tweet["external_id"].to_f
        twitter_account.update_attribute("last_status_id", tweet["external_id"])
      end
    end
    render :json => true, :status => 201
  end
end
