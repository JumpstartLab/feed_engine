attributes :id, :created_at
node(:type)        { |post| post.postable_type }
node(:feed)        { |post| api_feed_url(post.user.display_name.downcase) }
node(:link)        { |post| api_item_url(post.user.display_name.downcase, post.id) }
node(:refeed)      { |post| post.refeed? }
node(:refeed_link) do |post|
  if post.refeed?
    api_item_url(post.refeed_id)
  else
    ""
  end
end
