extends "api/items/post_base"

node(:image_url)   { |post| post.postable.image }
node(:description) { |post| post.postable.description }
