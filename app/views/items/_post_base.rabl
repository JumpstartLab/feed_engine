attributes :id, :created_at, :refeed_id
node(:type)             { |post| post.postable_type }
node(:feed)             { |post| feed_url(post.user.display_name.downcase) }
node(:link)             { |post| item_url(post.user.display_name.downcase, post.id) }
node(:refeed)           { |post| post.refeed? }
node(:total_points)     { |post| post.points.size }

