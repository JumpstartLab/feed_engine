class Tweet < ActiveRecord::Base
  include Post
  attr_accessible :source_id, :handle, :tweet_time
end
