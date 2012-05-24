class Api::RelationshipsController < Api::BaseController
  skip_before_filter :authenticate_user
  #before_filter :require_master_token

  def index
    @relationships = Relationship.relationship_summary
  end
end
