extends "items/post_base"

node(:body)        { |post| post.postable.body }
node(:title)       { |post| post.postable.title }
node(:text_post_id) { |post| post.postable.id }

