require 'minitest_helper'

describe Post do
  describe "#for_feed" do
    it "returns all of the posts for a user with a given display_name" do
      user = Fabricate(:user)
      posts = []
      FEED_TYPES.each do |type|
        fab_type = "#{type.to_s.downcase}_post".to_sym
        posts << Fabricate(fab_type, :user_id => user.id)
      end
      assert_equal Post.for_feed(user.display_name), posts
    end
  end
end
