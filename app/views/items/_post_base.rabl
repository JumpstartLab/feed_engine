attributes :id, :created_at, :refeed_id
node(:type)             { |post| post.postable_type }
node(:feed)             { |post| feed_url(post.user.display_name.downcase) }
node(:link)             { |post| item_url(post.user.display_name.downcase, post.id) }
node(:refeed)           { |post| post.refeed? }
node(:total_points)     { |post| post.points.size }
node(:gravatar_url) do |post|
  if post.refeed?
    user = Post.find(post.refeed_id).user
    user.gravatar_url
  else
    post.user.gravatar_url
  end
end