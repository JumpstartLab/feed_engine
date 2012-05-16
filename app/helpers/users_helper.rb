module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      "Twitter has been linked!"
    else
      link_to "Link your Twitter account", "/auth/twitter", class: "btn btn-info"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      "Github has been linked!"
    else
      link_to "Link your Github account", "/auth/github", class: "btn btn-info"
    end
  end
end
