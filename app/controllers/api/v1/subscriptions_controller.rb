class Api::V1::SubscriptionsController < Api::V1::ApiController
  
  def index
    @subscriptions = Subscription.all
  end

end
