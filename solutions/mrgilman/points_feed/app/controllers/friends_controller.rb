class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    friendship = current_user.friendships.where(:friend_id => params[:id]).first
    friendship.destroy if friendship
    redirect_to dashboard_path, :notice => "That user has been removed"
  end
end
