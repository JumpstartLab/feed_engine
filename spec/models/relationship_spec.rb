require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end

  describe "when follower it is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end

  describe "when followed it is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when a last_post_id is not present" do
    before { relationship.last_post_id = nil }
    it { should be_valid }
  end
end