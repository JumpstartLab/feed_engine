attributes :id, :created_at

node(:repo_name)        { |post| post.repo_name }
node(:repo_url)         { |post| post.repo_url }
node(:github_type)      { |post| post.github_type}

node(:type)        { |post| post.class.name }
node(:feed)        { |post| feed_url(post.user.display_name.downcase) }
node(:link)        { |post| item_url(post.user.display_name, post.id) }