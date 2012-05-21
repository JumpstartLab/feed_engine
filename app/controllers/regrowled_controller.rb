class RegrowledController < ApplicationController
  before_filter :authenticate_user!

  def create
    growl = Growl.find(params[:id])
    if growl && growl.build_regrowl_for(current_user).save
      render status: :created, json: "Refeed Successful"
    end
  end

end
