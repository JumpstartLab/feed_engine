class TwitterItem < ActiveRecord::Base
  attr_accessible :tweet, :tweet_time

  belongs_to :user
  has_many :stream_items, :as => :streamable

  serialize :tweet
end
