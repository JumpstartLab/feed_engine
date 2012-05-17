class RefeedsController < ApplicationController

  def create
    post = Post.find(params[:post_id])

    if post.user == current_user
      flash[:notice] = "Can't refeed your own post"
      redirect_to :back
    elsif current_user.posts.map(&:refeed_id).compact.include?(post.id)
      flash[:notice] = "Don't get greedy! You've already refeeded this post"
      redirect_to :back
    else
      original_post = post
      postable      = post.postable

      postable_copy = postable.dup
      current_user.posts.create({postable: postable_copy, refeed_id: original_post.id}, validate: false)
      redirect_to user_path(post.user)
    end
  end

end
