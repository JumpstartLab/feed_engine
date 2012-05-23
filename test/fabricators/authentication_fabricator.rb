Fabricator(:basic_auth, :class_name => Authentication) do
  user_id     { Fabricate(:user).id }
  handle      "omar"
  uid         { "uid#{Time.now.to_i.to_s}" }
  token       { "token#{Time.now.to_i.to_s}" } 
end

Fabricator(:twitter_auth, :from => :basic_auth) do
  provider    "twitter"
  handle      "@omar"
end

Fabricator(:github_auth, :from => :basic_auth) do
  provider    "github"
end

Fabricator(:instagram_auth, :from => :basic_auth) do
  provider    "instagram"
end
