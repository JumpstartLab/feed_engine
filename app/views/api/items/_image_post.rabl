extends "api/items/post_base"

node(:url)   { |post| post.postable.image_url }
node(:description) { |post| post.postable.description }
