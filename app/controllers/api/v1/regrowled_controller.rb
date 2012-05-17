class Api::V1::RegrowledController < Api::V1::ApiController

  def create
    Growl.regrowled_new(params[:id], current_user.id)
    render location: @growl, status: :created
  end
end