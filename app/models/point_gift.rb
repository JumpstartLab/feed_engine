# == Schema Information
#
# Table name: point_gifts
#
#  id         :integer         not null, primary key
#  item_id    :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# Join table of the users and items they have given points to
class PointGift < ActiveRecord::Base
  after_create :increase_point
  attr_accessible :item_id, :user_id

  belongs_to :user
  belongs_to :item

  def increase_point
    post_type = item.post_type.constantize
    post = post_type.find(item.post_id)
    post.increase_point_count
  end

end
