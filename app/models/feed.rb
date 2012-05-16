class Feed < ActiveRecord::Base
  attr_accessible :user_id, :private, :name, :link

  belongs_to :user

  def posts
    user.posts
  end
end
