class RegrowledController < ApplicationController
  before_filter :authenticate_user!

  #SHOULD BE MOVED TO A REGROWLCONTROLLER
  def create
    growl = Growl.find(params[:id])
    if growl && growl.build_regrowl_for(current_user).save
      render status: :created, json: "Regrowl Successful"
    end
  end

end
