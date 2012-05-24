module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      link_to image_tag("/assets/twitter_logo.gif"), 
      authentication_url("twitter"), 
      method: "delete", id: "unlink_twitter"
    else
      link_to image_tag("/assets/twitter_logo_lnkme.gif"), 
      "/auth/twitter", 
      method: "post", class: "link_twitter"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      link_to image_tag("/assets/github_logo.gif"), 
      authentication_url("github"), 
      method: "delete", class: "unlink_github"
    else
      link_to image_tag("/assets/github_logo_lnkme.gif"), 
      "/auth/github", 
      method: "post", class: "link_github"
    end
  end

  def instagram_button
    if current_user.provider_added?("instagram")
      link_to image_tag("/assets/instagram_logo.gif"), 
      authentication_url("instagram"), 
      method: "delete", class: "unlink_instagram"
    else
      link_to image_tag("/assets/instagram_logo_lnkme.gif"), 
      "/auth/instagram", 
      method: "post", class: "link_instagram"
    end
  end
end
