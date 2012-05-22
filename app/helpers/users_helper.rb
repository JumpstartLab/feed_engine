module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      "Twitter has been linked!"
      link_to "unlink twitter", authentication_url("twitter"), method: "delete", class: "btn btn-danger"
    else
      link_to "Link your Twitter account", "/auth/twitter", method: "post", class: "btn btn-info"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      "Github has been linked!"
      link_to "unlink github", authentication_url("github"), method: "delete", class: "btn btn-danger"
    else
      link_to "Link your Github account", "/auth/github", method: "post", class: "btn btn-info"
    end
  end
end
