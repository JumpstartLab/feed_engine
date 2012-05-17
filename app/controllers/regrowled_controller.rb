class RegrowledController < ApplicationController
  before_filter :authenticate_user!

  def create
    growl = Growl.find(params[:id])
    growl.regrowled(current_user.id)
    render status: :created, json: "Refeed Successful"
  end

end
