module SignupLinkGithubHelper
  def github_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "github").any?
  end
end
