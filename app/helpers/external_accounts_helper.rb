module ExternalAccountsHelper
  def twitter_connected?
    Authentication.where("user_id = ? and provider = ?", current_user.id, "twitter").any?
  end

  def github_connected?
    Authentication.where("user_id = ? and provider = ?", current_user.id, "github").any?
  end
end
