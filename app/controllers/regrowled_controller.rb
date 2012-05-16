class RegrowledController < ApplicationController
  before_filter :authenticate_user!

  def create
    Growl.regrowled_new(params[:id], current_user.id)
    redirect_to root_path, :notice => "Regrowl Successful"
  end

end
