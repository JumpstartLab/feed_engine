class Api::FriendsController < Api::ApiController
  before_filter :authenticate_user!

  def create
    friend = User.where(:id => params[:friend_id]).first
    friendship = Friendship.new(
      :user_id => current_user.id, 
      :friend_id => friend.id, 
      :status => Friendship::ACTIVE)

    if friendship.save
      success(201)
    else
      validation_error(friendship)
    end
  end
  
end
