require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "following?" do
    let(:other_user) { FactoryGirl.create(:user) }
    before(:each) do
      user.follow(other_user)
    end

    it "returns true if user is following another user" do
      user.following?(other_user).should be true
    end

    describe "followed_users" do
      it "contains other_user" do
        user.followed_users.should include(other_user)
      end
    end

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(user) }
    end

    describe "and unfollowing" do
      before { user.unfollow(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end
end