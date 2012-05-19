attributes :id, :created_at

node(:link_url)    { |post| post.url }
node(:comment)     { |post| post.description }
node(:type)        { |post| post.class.name }
