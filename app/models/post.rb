# == Schema Information
#
# Table name: posts
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  postable_id   :integer
#  postable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  refeed_id     :integer
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, :polymorphic => true, dependent: :destroy
  has_many :points
  attr_accessible :postable, :refeed_id

  def refeed?
    refeed_id.present?
  end

  def self.feed_for_user(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id).extend(PageExtension)
  end

  def self.refeed_post(post, user)
    original_post = post
    postable      = post.postable
    postable_copy = postable.dup

    if postable.is_a?(ImagePost) && postable.external_image_url.blank?
      postable_copy.external_image_url = postable.image.to_s
      postable_copy.send(:write_attribute, :image, nil)
    end

    user.posts.create({postable: postable_copy, refeed_id: original_post.id}, validate: false)
  end
end
