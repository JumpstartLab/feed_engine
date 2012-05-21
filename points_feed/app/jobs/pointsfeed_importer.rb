class PointsfeedImporter
  @queue = :medium

  def self.perform
    User.all.each do |user|
      import_posts(user)
    end
  end

  private

  def self.import_posts(user)
    posts = user.active_friends.map { |friend| friend.posts() }.flatten.uniq
    posts.each do |post|
      post.refeed(user)
    end
  end
end