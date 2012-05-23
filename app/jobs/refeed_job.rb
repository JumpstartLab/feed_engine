require 'troutr'
class RefeedJob
  @queue = :refeed

  EXTERNAL_TYPES = ["GithubItem","TwitterItem","InstagramItem"]
  def self.perform(current_user, subscription)
    #Resque.enqueue(RefeedJob, follower, followed_user, subscription)
    #
    #
    subscriber = User.find(current_user["id"])
    subscription = Subscription.find(subscription["id"])
    followed_user = User.find(subscription["followed_user_id"])

    orig_stream_items = followed_user.stream_items.where(:refeed => false)
    new_stream_items = orig_stream_items.select { |post| post.created_at >= subscription.created_at }
    posts = new_stream_items.collect {|si| si.streamable }
    troutr_posts = posts.select { |post| !EXTERNAL_TYPES.include?(post.class.name) }

    troutr_posts.each do |post|
      unless subscriber.stream_items.where(:streamable_id => post.id).where(:streamable_type => post.class.name).any?
        subscriber.add_stream_item(post)
      end
    end
  end
end

# for api:
# Troutr::Client.new(:token => follower_token)
# need followed_user id
#
#
# NEED: Api => new_feed_items(display_name, stream_item_id)


  def self.perform(follower, followed_user, subscription, last_stream_item_id, troutr_token)

    troutr = Troutr::Client.new(token: troutr_token, url: TROUTR_API_URL)

    new_stream_items_json = troutr.new_feed_items(followed_user["display_name"], last_stream_item_id)

    new_stream_items_json.each do |item|
      troutr.retrout_item(follower["display_name"], item["id"])
    end
  end
