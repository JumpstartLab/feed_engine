class SubscriptionJob
  @queue = :subscription

  def self.perform
    Authentication.all.each do |auth|
      Resque.enqueue("#{auth.provider.capitalize}Job".constantize, auth.user, auth)
    end
    Subscription.all.each do |sub|
      Resque.enqueue(RefeedJob, sub.user, sub)
    end
  end
end

