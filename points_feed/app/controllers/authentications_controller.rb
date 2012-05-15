class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, only: :create

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])
    unless current_user.twitter_name.present?
      current_user.update_attribute(:twitter_name, auth["extra"]["raw_info"]["screen_name"])
    end
    flash[:notice] = "Authentication successful"
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
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
