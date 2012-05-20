class SubscriptionsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_user_id])
    current_user.subscriptions.create(:followed_user_id => params[:followed_user_id])
    redirect_to :back, :notice => "Added #{followed_user.display_name} to your TackleBox!"
  end

  def destroy
    sub = current_user.subscriptions.find(params[:id])
    followed_user = sub.followed_user
    sub.destroy
    redirect_to :back, :notice => "No longer following #{followed_user.display_name}"
  end
end
