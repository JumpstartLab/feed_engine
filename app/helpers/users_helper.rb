module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      link_to "Unlink Twitter", authentication_url("twitter"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link Twitter", "/auth/twitter", method: "post", class: "btn btn-small btn-info"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      link_to "Unlink Github", authentication_url("github"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link Github", "/auth/github", method: "post", class: "btn btn-small btn-info"
    end
  end

  def instagram_button
    if current_user.provider_added?("instagram")
      link_to "Unlink Instagram", authentication_url("instagram"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link Instagram", "/auth/instagram", method: "post", class: "btn btn-info"
    end
  end
end
