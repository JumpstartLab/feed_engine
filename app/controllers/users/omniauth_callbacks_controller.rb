class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    data = request.env["omniauth.auth"]
    raise data.inspect
    auth = current_user.authentications.create(provider: data["provider"],
                                        token: data["credentials"]["token"],
                                        secret: data["credentials"]["secret"])
    # FIX THIS XXXX
    # auth.create_twitter_account()
    redirect_to new_authentication_path, :notice => "Twitter account successfully added."
  end

  def github
    data = request.env["omniauth.auth"]
    current_user.authentications.create(provider: data["provider"],
                                        token: data["credentials"]["token"],
                                        secret: data["credentials"]["secret"])
    redirect_to new_authentication_path, :notice => "Github account successfully added."
  end
end
