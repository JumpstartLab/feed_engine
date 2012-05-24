collection @users

attribute :display_name

node(:token) { |user|
  user.authentication_token
}

node(:auth) { |user|
  auth = {}

  twitter   = user.auth_for("twitter")
  github    = user.auth_for("github")
  instagram = user.auth_for("instagram")

  if twitter
    auth[:twitter] = {
      user_id: twitter.uid,
      since_id: user.last_twitter_id,
    }
  end

  if github
    auth[:github] = {
      username: github.username,
      since_id: github.last_github_id,
    }
  end

  if instagram
    auth[:instagram] = {
      token:    instagram.token,
      since_id: user.last_instagram_id,
    }
  end

  auth
}

node(:follows) { |user|
  user.followed_users.map do |user|
    {
      display_name: user.display_name,
    }
  end
}
