attributes :id, :created_at, :description

node(:url)         { |post| post.image_url }
node(:type)        { |post| post.class.name }
