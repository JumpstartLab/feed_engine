class RelationshipsController < ApplicationController
  respond_to :json, :xml

  def index
    @relationships = Relationship.all
  end

  def create
    current_user.relationships.create(followed_id: user.id,
                                      follower_id: current_user.id,
                                      last_post_id: user.last_post.id)
    redirect_to :back
  end

  def destroy
    relationship = current_user.relationships.find_by_followed_id(user)
    relationship.destroy
    redirect_to :back
  end
end
