class SubscriptionJob
  @queue = :subscription

  def self.perform
    Authentication.all.each do |auth|
      Resque.enqueue("#{auth.provider.capitalize}Job".constantize, auth.user, auth)
    end
  end
end

