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
end
