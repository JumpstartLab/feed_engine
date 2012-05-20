attributes :id, :created_at, :body, :title

node(:type)        { |post| post.class.name }
