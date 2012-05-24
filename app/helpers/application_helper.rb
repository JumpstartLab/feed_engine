module ApplicationHelper
  def gravatar_url(user)
    Gravatar.new(user.email).image_url
  end

  def github_connected?(user)
    service_connected(user, "github")
  end

  def twitter_connected?(user)
    service_connected(user, "twitter")
  end

  def instagram_connected?(user)
    service_connected(user, "instagram")
  end

  def service_connected(user, service)
    Authentication.where("user_id = ? and provider = ?", user.id, service).any?
  end

  def linked_services?(user)
    if user.nil?
      false
    else
      twitter_connected?(user) || github_connected?(user) || instagram_connected?(user)
    end
  end
end
