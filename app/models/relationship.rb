# == Schema Information
#
# Table name: relationships
#
#  id           :integer         not null, primary key
#  follower_id  :integer
#  followed_id  :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  last_post_id :integer
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id, :last_post_id
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates_presence_of :follower_id, :followed_id

end
