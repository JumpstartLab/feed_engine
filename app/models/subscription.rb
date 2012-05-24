class Subscription < ActiveRecord::Base
  belongs_to :user
  validates :feed_id, :presence => true
  attr_accessible :user_id, :feed_id, :last_imported_post_id

  def import_posts
    feed = Feed.find(self.feed_id)
    posts = if self.last_imported_post_id.nil?
      feed.posts_after_time(self.created_at)
    else
      feed.posts_after_id(last_imported_post_id)
    end

    posts.each do |orig_post|
      cloned_post = self.user.feed.posts.create
      cloned_post.update_attribute(:postable, orig_post.postable)
    end
    unless posts.empty?
      self.update_attribute(:last_imported_post_id, posts.first.id)
    end
  end
end
