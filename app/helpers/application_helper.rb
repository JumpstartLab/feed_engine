module ApplicationHelper

  def post_template_for_post(postable)
    if postable.class == ImagePost
      "image_posts/post"
    elsif postable.class == LinkPost
      "link_posts/post"
    elsif postable.class == TextPost
      "text_posts/post"
    elsif post.class == TwitterPost
      "twitter_posts/post"
    elsif post.class == GithubPost
      "github_posts/post"
    else
      "NEED TO ADD A GENERAL TEMPLATE"
    end
  end
end
