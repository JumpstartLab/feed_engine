class Api::V1::UserTweetsController < Api::V1::ApiController
  before_filter :verify_twitter_account

  def create
    tweets = JSON.parse(params["tweets"])
    tweets.each do |tweet|
      @user.tweets.create(link: tweet["link"],
                          comment: tweet["comment"],
                          original_created_at: tweet["created_at"])
      @user.twitter_account.update_last_status_id_if_necessary(tweet["status_id"])
    end
    render :json => true, :status => 201
  end

private

  def verify_twitter_account
    @user = User.where(id: params["user_id"]).first
    unless @user
      render :json => "User account cannot be found.", :status => 500
    end
  end
end
