extends "api/items/post_base"

node(:link_url)    { |post| post.postable.url }
node(:descrption)  { |post| post.postable.description }
