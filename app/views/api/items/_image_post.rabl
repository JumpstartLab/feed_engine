extends "api/items/post_base"

node(:image_url)   { |post| post.postable.image }
node(:comment)     { |post| post.postable.description }
