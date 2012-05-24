class Feed < ActiveRecord::Base
  attr_accessible :user_id, :private, :name, :link

  belongs_to :user
  has_many :posts
  has_many :subscriptions

  def posts_after_time(time)
    posts_after("created_at", time)
  end

  def posts_after_id(id)
    posts_after("id", id)
  end

  def posts_after(type, value)
    self.posts.where("#{type} > ?", value).order("#{type} DESC")
  end
end
