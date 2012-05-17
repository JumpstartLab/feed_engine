attributes :id, :created_at

node(:image_url)   { |post| post.image_url(:big).to_s }
node(:comment)     { |post| post.description }

node(:type)        { |post| post.class.name }
node(:feed)        { |post| feed_url(post.user.display_name.downcase) }
node(:link)        { |post| item_url(post.user.display_name, post.id) }

