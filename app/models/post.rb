module Post
  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user
    end
  end

  def self.for_feed(feed_name)
    Feed.find_by_name!(feed_name).posts
  end
end