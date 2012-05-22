require 'spec_helper'

describe GithubAccount do
  let!(:user) { FactoryGirl }
  let!(:authentication) { user.authentications.build }
  let!(:github_account) { authentication.build_github_account }

  describe "#user" do
    it "should return a user associated with this github account" do
      # raise user.inspect
      github_account.user.should == user
    end
  end
end
