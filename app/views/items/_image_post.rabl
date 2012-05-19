attributes :id, :created_at

node(:url)         { |post| post.url }
node(:description) { |post| post.description }
node(:type)        { |post| post.class.name }
