extends "api/items/post_base"
node(:repo_name)        { |post| post.postable.repo_name }
node(:repo_url)         { |post| post.postable.repo_url }
node(:github_type)      { |post| post.postable.github_type}
