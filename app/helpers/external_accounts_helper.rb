module ExternalAccountsHelper
  def twitter_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "twitter").any?
  end

  def github_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "github").any?
  end
end
