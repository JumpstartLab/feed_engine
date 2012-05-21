module PostsHelper
  def link_to_poly_post(typed_post, feed)
    poly_post = feed.posts.create
    poly_post.postable = typed_post
    poly_post.save
  end
end
