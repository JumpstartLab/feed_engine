require 'minitest_helper'

describe Feed do
  it "has a name that is the same as the user's subdomain" do
    user = Fabricate(:user, :display_name => "test")
    assert_equal user.feed.valid?, true
    assert_equal user.feed.name, "test"
  end
  
  it "is public by default" do
    user = Fabricate(:user, :display_name => "public")
    assert_equal user.feed.private?, false
  end
  
  describe ".posts" do
    it "returns all of a user's posts" do
      user = Fabricate(:user)
      user.posts << Fabricate(:link_post)
      assert_equal user.feed.posts, user.posts
    end
  end
  
  describe ".private?" do
    it "returns true if the feed is private" do
      user = Fabricate(:user)
      user.feed.update_attribute(:private, true)
      assert_equal user.feed.private?, true
    end
    
    it "returns false if the feed is public" do
      user = Fabricate(:user)
      user.feed.update_attribute(:private, false)
      assert_equal user.feed.private?, false
    end
  end
  
  describe ".posts_after_time" do
    it "returns all of the posts in a given feed after a given time" do
      feed = Fabricate(:feed)
      post1 = fabricate_post(feed)
      post2 = fabricate_post(feed)
      post1.update_attribute(:created_at, 1.hour.ago)
      assert_equal [post2], feed.posts_after_time(30.minutes.ago)
    end
  end
  
  describe ".posts_after_id" do
    it "returns all of the posts in a given feed after a given id" do
      feed = Fabricate(:feed)
      post1 = fabricate_post(feed)
      post2 = fabricate_post(feed)
      assert_equal [post2], feed.posts_after_id(post1.id)
    end
  end
end
