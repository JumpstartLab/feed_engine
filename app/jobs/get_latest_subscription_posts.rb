module GetLatestSubscriptionPosts
  @queue = :subscription_posts_low
  def self.perform()
    Subscription.all.each do |sub|
      sub.import_posts
    end    
  end
end