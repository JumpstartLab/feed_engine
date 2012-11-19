require 'minitest_helper'

module PostTestHelpers
  def fabricate_post(feed, post_type="text")
    post = feed.posts.create
    post.postable = Fabricate("#{post_type}_post".to_sym)
    post.save
    post
  end
end