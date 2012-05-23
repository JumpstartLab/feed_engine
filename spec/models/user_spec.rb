require 'spec/helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(user) }
    end

    describe "and unfollowing" do
      before { user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end
end