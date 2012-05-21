class InstagramFeeder
  @queue = :instagram_queue
  def self.perform(user_id)
    Instagram.import_posts(user_id)
  end
end