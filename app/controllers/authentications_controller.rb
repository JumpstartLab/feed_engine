class AuthenticationsController < ApplicationController
  def new
    @authentication = Authentication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authentication }
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    uid = auth['uid']
    token = auth["credentials"]["token"]
    secret = auth["credentials"]["secret"]
    login = auth["extra"]["raw_info"]["login"]


    provider = auth[:provider]
    authentication = current_user.authentications.build(:provider => provider, :uid => uid, 
     :token => token, :secret => secret, :login => login)
    if current_user.save
      flash[:notice] = "Authentication successful."
    else
      flash[:error] = authentication.errors[:base].first
    end
    if session[:next_auth_path]
      redirect_to session[:next_auth_path]
    else
      redirect_to dashboard_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "You are no longer connected to this external service."
    redirect_to authentications_url

    respond_to do |format|
      format.html { redirect_to dashboard_url }
      format.json { head :no_content }
    end
  end
end
