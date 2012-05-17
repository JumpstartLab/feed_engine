class Api::V1::RefeedsController < Api::V1::ApiController
  
  def create
    growl = Growl.build_refeeded(current_user.id, params[:id])
    # Growl.build_refeeded(user_id,refeeded_from_user_id)

    if growl.save
      render location: @growl, status: :created
    else
      render :json => false, status: :not_acceptable
    end
  end

end
