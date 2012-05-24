class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(
                                        :provider => auth['provider'],
                                        :uid => auth['uid'].to_s,
                                        :handle => get_handle(auth),
                                        :token => auth["credentials"]["token"])
    render partial:"shared/fuck_this_shit"
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    provider = @authentication.provider.capitalize
    @authentication.destroy
    redirect_to root_path
  end

  def check
    @authd =  !(current_user.authentications.find_by_provider(params[:provider]) == nil)
  end

  private

  def get_handle(auth)
    case auth['provider']
      when "twitter"   then auth["extra"]["raw_info"]["screen_name"]
      when "github"    then auth["extra"]["raw_info"]["login"]
      when "instagram" then auth["info"]["nickname"]
    end
  end
end
