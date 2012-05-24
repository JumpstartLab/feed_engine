require 'troutr'
class RefeedJob
  @queue = :refeed

  EXTERNAL_TYPES = ["GithubItem","TwitterItem","InstagramItem"]
  def self.perform(follower, subscription)

    follower = User.find(follower["id"])
    subscription = Subscription.find(subscription["id"])
    followed_user = User.find(subscription["followed_user_id"])
    troutr_token = follower.authentication_token
    last_stream_item_id = follower.last_retrout_id_for_user(followed_user)

    troutr = Troutr::Client.new(token: troutr_token, url: TROUTR_API_URL)

    resp = troutr.user_recent_stream_items(followed_user["display_name"], last_stream_item_id)
    resp_body = JSON.parse(resp[1])

    new_stream_items = resp_body["recent_items"]

    new_stream_items.each do |item|
      unless EXTERNAL_TYPES.include?(item["type"]) || DateTime.parse(item["created_at"].to_s) < DateTime.parse(subscription["created_at"].to_s)
        troutr.retrout_item(followed_user.display_name, item["id"])
      end
    end
  end
end
