class TwitterItem < ActiveRecord::Base
  include Streamable
  attr_accessible :tweet, :tweet_time, :status_id

  has_many :stream_items, :as => :streamable

  serialize :tweet

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id,
        status_id: parsed_json["tweet"]["id_str"],
        tweet_time: parsed_json["tweet"]["created_at"],
        tweet: parsed_json["tweet"])
  end
end


# Tweet:
#   Status;
#   Attrs
#     created_at
#     id
#     id_str
#     text
#     source
#     truncated
#     in_reply_to
#     in_rep...
#     etc...
#
#     TimeStamp: twitter_item.tweet.created_at
#
#     TWEETJSON
#     {"status_id":"#{item.tweet.attrs["id_str"]}", "attrs":"#{t.tweet.attrs}"}
#
#     item.tweet.class == Twitter::Status
#     item.tweet.attrs.class == Hash --> parse this to json
