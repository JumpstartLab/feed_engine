class Friendship < ActiveRecord::Base
  PENDING = 1
  ACTIVE  = 2
  IGNORED = 3

  attr_accessible :friend_id, :user_id, :status

  validates :friend_id, :presence => true
  validates :user_id, :presence => true, :uniqueness => { :scope => :friend_id }

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validate do
    if self.friend_id == self.user_id
      self.errors.add(:friend_id, "Cannot friend yourself")
    end
  end

  def self.active
    where(:status => ACTIVE)
  end
end
