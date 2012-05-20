attributes :id, :created_at, :description

node(:link_url)    { |post| post.url }
node(:type)        { |post| post.class.name }
