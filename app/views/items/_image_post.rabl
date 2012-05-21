extends "items/post_base"

node(:url)         { |post| post.postable.url }
node(:description) { |post| post.postable.description }
node(:image_post_id) { |post| post.postable.id }
