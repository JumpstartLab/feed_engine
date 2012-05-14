class Friendship < ActiveRecord::Base
  PENDING = 1
  ACTIVE  = 2
  IGNORED = 3
  
  attr_accessible :friend_id, :user_id, :status

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  class << self
    def pending
      where(:status => PENDING)
    end

    def active
      where(:status => ACTIVE)
    end

    def ignored
      where(:status => IGNORED)
    end
  end

end
