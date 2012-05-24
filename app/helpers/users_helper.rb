module UsersHelper
  def twitter_button
    if current_user.provider_added?("twitter")
      link_to image_tag("/assets/twitter_unlink.gif"), 
      authentication_url("twitter"), 
      method: "delete", id: "unlink_twitter"
    else
      link_to image_tag("/assets/twitter_link.gif"), 
      "/auth/twitter", 
      method: "post", class: "link_twitter"
    end
  end

  def github_button
    if current_user.provider_added?("github")
      link_to image_tag("/assets/github_unlink.gif"), 
      authentication_url("github"), 
      method: "delete", class: "unlink_github"
    else
      link_to image_tag("/assets/github_link.gif"), 
      "/auth/github", 
      method: "post", class: "link_github"
    end
  end

  def instagram_button
    if current_user.provider_added?("instagram")
      link_to image_tag("/assets/instagram_unlink.gif"), 
      authentication_url("instagram"), 
      method: "delete", class: "unlink_instagram"
    else
      link_to image_tag("/assets/instagram_link.gif"), 
      "/auth/instagram", 
      method: "post", class: "link_instagram"
    end
  end
end
