class RelationshipsController < ApplicationController
  def create
    current_user.relationships.create(followed_id: user.id, follower_id: current_user.id)
    redirect_to :back
  end

  def destroy
    relationship = current_user.relationships.find_by_followed_id(user)
    relationship.destroy
    redirect_to :back
  end
end
