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
#  points        :integer         default(0)
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
end
