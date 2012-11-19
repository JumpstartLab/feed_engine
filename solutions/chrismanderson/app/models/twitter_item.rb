class TwitterItem < ActiveRecord::Base
  include Streamable
  attr_accessible :tweet, :tweet_time, :status_id

  has_many :stream_items, :as => :streamable

  serialize :tweet

  def tweet_text
    tweet["text"]
  end

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id,
        status_id: parsed_json["tweet"]["id_str"],
        tweet_time: parsed_json["tweet"]["created_at"],
        tweet: parsed_json["tweet"])
  end
end
