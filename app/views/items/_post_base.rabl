attributes :id, :created_at
node(:type)        { |post| post.postable_type }
node(:feed)        { |post| feed_url(post.user.display_name.downcase) }
node(:link)        { |post| item_url(post.user.display_name.downcase, post.id) }
node(:refeed)      { |post| post.refeed? }
