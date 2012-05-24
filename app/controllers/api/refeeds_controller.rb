class Api::RefeedsController < Api::BaseController
  def create
    if params.fetch(:user_display_name).downcase == current_user.display_name.downcase
      head status: 400
    else
      original_post = Post.find(params[:item_id])
      postable      = original_post.postable
      postable_copy = postable.dup

      if postable.is_a?(ImagePost) && postable.external_image_url.blank?
        postable_copy.external_image_url = postable.image.to_s
        postable_copy.send(:write_attribute, :image, nil)
      end

      current_user.posts.create(postable: postable_copy, refeed_id: original_post.id)

      head status: 201
    end
  end
end
