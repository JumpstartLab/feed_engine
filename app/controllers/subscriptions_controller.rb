class SubscriptionsController < ApplicationController
  def new

  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    if @subscription.save
      notice = "Your account has been linked with twitter"
      redirect_to dashboard_path, notice: notice
    else
      render :new
    end
  end


end
