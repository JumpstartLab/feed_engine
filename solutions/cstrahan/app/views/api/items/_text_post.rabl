extends "api/items/post_base"

node(:title) { |post| post.postable.title }
node(:body)  { |post| post.postable.body }
