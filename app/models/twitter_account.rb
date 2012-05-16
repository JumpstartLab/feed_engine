class TwitterAccount < ActiveRecord::Base
  belongs_to :authentication
  has_one :user, :through => :authentication
  attr_accessible :authentication, :uid, :nickname, :initial_status, :image

  def user_id
    user.id
  end

  def last_status_id
    if user.has_tweets?
      user.tweets.order(:external_id).last.external_id
    else
      initial_status
    end
  end
end
