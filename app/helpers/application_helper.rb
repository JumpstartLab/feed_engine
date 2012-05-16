module ApplicationHelper
  def gravatar_url(user = nil)
    if user
      Gravatar.new(user.email).image_url
    else
      Gravatar.new("example").image_url
    end
  end
end
