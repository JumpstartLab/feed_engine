extends "items/post_base"

node(:link_url)    { |post| post.postable.url }
node(:description)     { |post| post.postable.description }
node(:link_post_id) { |post| post.postable.id }

