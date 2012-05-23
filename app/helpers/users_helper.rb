module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      "Twitter has been linked!"
      link_to "Unlink twitter", authentication_url("twitter"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link your Twitter account", "/auth/twitter", method: "post", class: "btn btn-small btn-info"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      "Github has been linked!"
      link_to "Unlink github", authentication_url("github"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link your Github account", "/auth/github", method: "post", class: "btn btn-small btn-info"
    end
  end

  def instagram_button
    if current_user.provider_added?("instagram")
      "Instagram has been linked!"
      link_to "Unlink instagram", authentication_url("instagram"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link your Instagram account", "/auth/instagram", method: "post", class: "btn btn-info"
    end
  end
end
