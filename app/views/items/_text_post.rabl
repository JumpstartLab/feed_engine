attributes :id, :created_at

node(:text)        { |post| post.body }

node(:type)        { |post| post.class.name }
node(:feed)        { |post| feed_url(post.user.display_name.downcase) }
