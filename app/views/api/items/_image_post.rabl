extends "api/items/post_base"

node(:image_url)   { |post| post.postable.image_url(:big).to_s }
node(:comment)     { |post| post.postable.description }
