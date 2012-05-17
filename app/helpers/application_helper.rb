module ApplicationHelper

  def post_template_for_post(post)
    if post.class == ImagePost
      "image_posts/post"
    elsif post.class == LinkPost
      "link_posts/post"
    elsif post.class == TextPost
      "text_posts/post"
    elsif post.class == TwitterPost
      "twitter_posts/post"
    elsif post.class == GithubPost
      "github_posts/post"
    else
      "NEED TO ADD A TEMPLATE"
    end
  end
end
