class RefeedsController < ApplicationController

  def create
    if own_post?
      flash[:notice] = "Can't refeed your own post"
      redirect_to :back
    elsif already_refeeded?
      flash[:notice] = "Don't get greedy! You've already refeeded this post"
      redirect_to :back
    else refeed_post
      flash[:notice] = "Refeeded!"
      redirect_to user_path(post.user)
    end
  end

  private

  def own_post?
    post.user == current_user
  end

  def already_refeeded?
    current_user.posts.map(&:refeed_id).compact.include?(post.id)
  end

  def post
    post = Post.find(params[:post_id])
  end

  def refeed_post
    original_post = post
    postable      = post.postable
    postable_copy = postable.dup

    if postable.is_a?(ImagePost) && postable.external_image_url.blank?
      postable_copy.external_image_url = postable.image.to_s
      postable_copy.send(:write_attribute, :image, nil)
    end

    current_user.posts.create({postable: postable_copy, refeed_id: original_post.id}, validate: false)
  end

end
