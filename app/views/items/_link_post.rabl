attributes :id, :created_at

node(:link_url)    { |post| post.url }
node(:comment)     { |post| post.description }

node(:type)        { |post| post.class.name }
node(:feed)        { |post| feed_url(post.user.display_name.downcase) }
node(:link)        { |post| item_url(post.user.display_name, post.id) }
node(:refeed)      { |post| post.refeed? }
node(:refeed_link) do |post|
  if post.refeed?
    item_url(post.refeed_id)
  else
    ""
  end
end
