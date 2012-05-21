class PointsfeedImporter
  @queue = :medium

  def self.perform
    User.all.each do |user|
      import_posts(user)
    end
  end

  private

  def self.import_posts(user)
    get_posts_for_friends(user).each do |post|
      post.refeed(user)
    end
  end

  def self.get_posts_for_friends(user)
    friendships = user.friendships.where(:status => Friendship::ACTIVE)
    posts = friendships.map do |friendship|
      posts = friendship.friend.posts.where("created_at >= ?", friendship.created_at)
    end
    posts.flatten.uniq
  end
end