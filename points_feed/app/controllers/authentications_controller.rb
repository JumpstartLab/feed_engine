class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])
    flash[:notice] = "Authentication succesful"
    redirect_to authentications_url
    # @authentication = Authentication.new(params[:authentication])
    # if @authentication.save
    #   redirect_to authentications_url, :notice => "Successfully created authentication."
    # else
    #   render :action => 'new'
    # end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
