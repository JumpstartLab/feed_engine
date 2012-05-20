extends "items/post_base"

node(:link_url)    { |post| post.postable.url }
node(:comment)     { |post| post.postable.description }
