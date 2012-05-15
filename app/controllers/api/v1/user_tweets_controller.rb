class Api::V1::UserTweetsController < ActionController::Base
  respond_to :json

  def index
    @users = User.find_twitter_users
  end

  def create
    Tweet.create(comment: "BOOM")
    # tweets = JSON.parse(params["tweets"])
    # tweets.each do |tweet|
      # Tweet.create(tweet)
    # end
    render :json => true, :status => 201
  end
end
