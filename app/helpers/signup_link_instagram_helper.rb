module SignupLinkInstagramHelper
  def instagram_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "instagram").any?
  end
end
