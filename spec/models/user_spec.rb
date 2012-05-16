require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  context "#send_welcome_message" do
    it "should call the UserMailer" do
      Mail::Message.any_instance.should_receive(:deliver)
      user.send_welcome_message
    end
  end

  context "#twitter_client" do
    context "if user has not linked his account with Twitter" do
      it "should return nil" do
        user.tweets.should == []
      end
    end

    context "if user has linked his account with Twitter" do
      let!(:authentication) { user.authentications.create(provider: 'twitter') }
      it "should return a Twitter client instance" do
        user.twitter?.should == true
      end
    end
  end

  context "#has_tweets?" do
    context "if user has not linked his account with Twitter" do
      it "should return false" do
        user.tweets.should == []
      end
    end
  end
end