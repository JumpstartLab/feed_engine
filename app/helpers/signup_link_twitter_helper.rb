module SignupLinkTwitterHelper
  def twitter_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "twitter").any?
  end
end
