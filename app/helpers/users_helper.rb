module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      "Twitter has been linked!"
      link_to "unlink twitter", authentication_url("twitter"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link Twitter!", "/auth/twitter", method: "post", class: "btn btn-info btn-large"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      "Github has been linked!"
      link_to "unlink github", authentication_url("github"), method: "delete", class: "btn btn-small btn-danger"
    else
      link_to "Link Github!", "/auth/github", method: "post", class: "btn btn-info btn-large"
    end
  end

  def instagram_button
    if current_user.provider_added?("instagram")
      "Instagram has been linked!"
      link_to "Unlink instagram", authentication_url("instagram"), method: "delete", class: "btn btn-danger"
    else
      link_to "Link Instagram!", "/auth/instagram", method: "post", class: "btn btn-info btn-large"
    end
  end
end
