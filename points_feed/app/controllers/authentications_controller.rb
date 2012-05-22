class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, only: :create

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env['omniauth.auth']
    add_authentication(auth)

    flash[:notice] = "#{auth['provider'].titlecase} account linked."
    redirect_to session[:authentication_workflow]
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to dashboard_path, 
                :notice => "Successfully destroyed authentication."
  end

  private

  def add_authentication(auth)
    provider, uid = auth['provider'], auth['uid']
    authentication = current_user.get_authentication(provider, uid)
    authentication.update_attributes(:secret => auth['credentials']['token'])
    github_authentication(authentication, auth) if provider == 'github'
    twitter_authentication(authentication, auth) if provider == 'twitter'
  end

  def github_authentication(authentication, auth)
    login = auth['extra']['raw_info']['login']
    authentication.update_attributes(:login => login)
   end

  def twitter_authentication(authentication, auth)
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    authentication.update_attributes(:login => token, :secret => secret)
  end

  # def pretty_hash(hash)
  #   results = []
  #   hash.keys.each do |key|
  #     results << key
  #     if hash[key].respond_to?(:keys)
  #       results << pretty_hash(hash[key]).split("\n").map do | line |
  #         " -- " + line
  #       end
  #     end
  #   end
  #   results.join("\n")
  # end
end
