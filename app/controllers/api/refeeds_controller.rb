class Api::RefeedsController < Api::BaseController
  def create
    if params.fetch(:user_display_name).downcase == current_user.display_name.downcase
      head status: 400
    else
      original_post = Post.find(params[:item_id])
      postable      = original_post.postable

      postable_copy = postable.dup
      current_user.posts.create(postable: postable_copy, refeed_id: original_post.id)

      head status: 201
    end
  end
end
