module PostsHelper

  def formatted_type(post)
    post.type.gsub("Post", "")
  end

  def formatted_posted_at(post)
    time_ago_in_words(post.created_at) + " ago"
  end
end
