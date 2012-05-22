class Api::AwardsController < Api::ApiController
  before_filter :authenticate_user!

  def create
    award = current_user.awards.create(awardable_id: params[:id],
                                       awardable_type: params[:type])
    success(201)
  end

end