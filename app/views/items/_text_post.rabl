attributes :id, :created_at

node(:body)        { |post| post.body }
node(:title)       { |post| post.title }
node(:type)        { |post| post.class.name }
