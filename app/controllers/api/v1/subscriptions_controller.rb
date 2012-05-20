class Api::V1::SubscriptionsController < Api::V1::ApiController
  #XXX
  #NEEDS TO BE LOCKED DOWN FOR BACKGROUND JOB ONLY

  def index
    @subscriptions = Subscription.all
  end

end
