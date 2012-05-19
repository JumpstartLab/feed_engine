attributes :id, :created_at

node(:text)        { |post| post.text }
node(:type)        { |post| post.class.name }
