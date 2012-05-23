module ApplicationHelper
  def gravatar_url(user)
    Gravatar.new(user.email).image_url
  end

  def github_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "github").any?
  end

  def twitter_connected?(user)
    Authentication.where("user_id = ? and provider = ?", user.id, "twitter").any?
  end

  def linked_services?(user)
    if user.nil?
      false
    else
      twitter_connected?(user) || github_connected?(user)
    end
  end
end
