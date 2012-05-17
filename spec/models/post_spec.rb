require 'spec_helper'

describe Post do
  describe "#add_point" do
    it "increases the total points for a post by 1" do
      post = FactoryGirl.create(:post)
      post.points = 1
      post.add_point
      post.points.should == 2
    end
  end
end