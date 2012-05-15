module UsersHelper
  def twitter_button
    if current_user.twitter_linked?
      "Twitter has been linked!"
    else
      link_to "Link your Twitter account", "/auth/twitter", class: "btn btn-info"
    end
  end
end
