object @post

node do |post|
  partial("api/items/#{post.postable_type.underscore}", object: post.postable)
end
