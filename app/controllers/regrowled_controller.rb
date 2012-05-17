class RegrowledController < ApplicationController
  before_filter :authenticate_user!

  def create
    growl = Growl.find(params[:id])
    if growl.regrowled(current_user.id)
      redirect_to root_path, :notice => "Regrowl Successful"
    else
      redirect_to root_path, :notice => "You can't regrowl yourself!"
    end
  end

end
