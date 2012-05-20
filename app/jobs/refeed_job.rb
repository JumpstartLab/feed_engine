class RefeedJob
  @queue = :refeed

  def self.perform(current_user, subscription)

    subscriber = User.find(current_user["id"])
    subscription = Subscription.find(subscription["id"])
    followed_user = User.find(subscription["followed_user_id"])

    orig_stream_items = followed_user.stream_items.where(:refeed => false)
    new_stream_items = orig_stream_items.select { |post| post.created_at >= subscription.created_at }
    posts = new_stream_items.collect {|si| si.streamable }

    posts.each do |post|
      unless subscriber.stream_items.where(:streamable_id => post.id).where(:streamable_type => post.class.name).any?
        subscriber.add_stream_item(post)
      end
    end
  end
end
