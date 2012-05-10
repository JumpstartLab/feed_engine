class SubscriptionsController < ApplicationController
  def new

  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      redirect_to dashboard_path, notice: "Thanks for signing up"
    else
      render :new
    end
  end


end
