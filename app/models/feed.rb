class Feed < ActiveRecord::Base
  attr_accessible :user_id, :private, :name, :link

  belongs_to :user

  def posts
    user.posts
  end

  def set_name(name)
    self.name = name
    self.save
  end

  def private?
    self.private
  end
end
