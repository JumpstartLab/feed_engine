attributes :id, :created_at

node(:image_url)   { |post| post.image_url(:big).to_s }
node(:comment)     { |post| post.description }

node(:type)        { |post| post.class.name }
node(:feed)        { |post| api_feed_url(post.user.display_name.downcase) }
node(:link)        { |post| api_item_url(post.id) }
node(:refeed)      { |post| post.refeed? }
node(:refeed_link) do |post|
  if post.refeed?
    api_item_url(post.refeed_id)
  else
    ""
  end
end
