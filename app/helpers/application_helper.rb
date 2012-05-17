module ApplicationHelper
  def gravatar_url(user)
    Gravatar.new(user.email).image_url
  end
end
