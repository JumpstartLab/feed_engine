extends "items/post_base"
node(:url)        { |post| post.postable.url}
