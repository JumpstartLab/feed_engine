class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(:provider => auth['provider'], :uid => auth['uid'].to_s, :handle => get_handle(auth))
    # Kernel.const_get("#{auth['provider'].capitalize}Feeder").perform(current_user.id)
    Resque.enqueue(Kernel.const_get("#{auth['provider'].capitalize}Feeder"), current_user.id)
    flash[:notice] = "#{auth['provider'].capitalize} link successful"
    redirect_to authentications_path
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    provider = @authentication.provider.capitalize
    @authentication.destroy
    flash[:notice] = "#{provider} has been removed"
    redirect_to authentications_path
  end

  private

  def get_handle(auth)
    case auth['provider']
      when "twitter"  then auth["extra"]["raw_info"]["screen_name"]
      when "github"   then auth["extra"]["raw_info"]["login"]
    end
  end
end
