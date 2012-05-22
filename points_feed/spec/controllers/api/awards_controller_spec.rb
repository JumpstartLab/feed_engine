require 'spec_helper'

describe Api::AwardsController do

  context "user awards point to a text item" do
    let!(:user) { Fabricate(:user) }
    let!(:text_post) { Fabricate(:text_post, :user_id => 1) }

    it "creates a point" do
      Award.count.should == 0
      user.awards.create(awardable_id: text_post.id,
                         awardable_type: "Post")
      Award.count.should == 1
    end

    it "adds the point to that item" do
      text_post.points.should == 0
      user.awards.create(awardable_id: text_post.id,
                         awardable_type: "Post")
      text_post.points.should == 1
    end

  end

end
