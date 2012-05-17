object @post

node do |post|
  partial("items/#{post.postable_type.underscore}", object: post.postable)
end
