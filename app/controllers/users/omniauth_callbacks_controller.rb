class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    data = request.env["omniauth.auth"]
    auth = current_user.authentications.create(provider: data["provider"],
                                        token: data["credentials"]["token"],
                                        secret: data["credentials"]["secret"])

    auth.create_twitter_account(uid: data["info"]["uid"],
                                nickname: data["info"]["nickname"],
                                image: data["info"]["image"],
                                last_status_id: data["extra"]["raw_info"]["status"]["id_str"])

    redirect_to new_authentication_path, :notice => "Twitter account successfully added."
  end

  def github
    data = request.env["omniauth.auth"]
    auth = current_user.authentications.create(provider: data["provider"],
                                        token: data["credentials"]["token"])

    auth.create_github_account(uid: data["uid"],
                               nickname: data["info"]["nickname"],
                               image: data["extra"]["raw_info"]["avatar_url"],
                               last_status_id: DateTime.now)

    redirect_to new_authentication_path, :notice => "Github account successfully added."
  end

  def instagram
    data = request.env["omniauth.auth"]
    auth = current_user.authentications.create(provider: data["provider"],
                                        token: data["credentials"]["token"])

    auth.create_github_account(uid: data["uid"],
                               nickname: data["info"]["nickname"],
                               image: data["info"]["image"],
                               last_status_id: DateTime.now)

    redirect_to new_authentication_path, :notice => "Instagram account successfully added."
  end
end
