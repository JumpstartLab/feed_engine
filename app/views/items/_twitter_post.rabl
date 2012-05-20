extends "items/post_base"
node(:text)        { |post| post.postable.text }
