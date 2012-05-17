# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  api_key                :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

require 'spec_helper'

describe User do
  let!(:user) { Fabricate(:user) }
  let(:new_user) { Fabricate.build(:user) }


  it "has an api key token after creation" do
    new_user.api_key = nil
    new_user.save
    new_user.api_key.should_not be_nil
  end

  it "has a unique api key for the same user reincarnated" do
    duplicate_user = new_user.dup
    new_user.save
    key = new_user.api_key
    new_user.destroy
    duplicate_user.save
    duplicate_user.api_key.should_not == key
  end

  it "can be queried for it's items" do
    Fabricate(:message, :poster_id => user.id)
    Fabricate(:image, :poster_id => user.id)
    Fabricate(:link, :poster_id => user.id)

    user.items.should_not be_empty
  end

  it "does not return items that belong to other users" do
    Fabricate(:message, :poster_id => user.id)
    Fabricate(:image, :poster_id => user.id)
    Fabricate(:link, :poster_id => user.id)

    user2 = Fabricate(:user)
    user2_items = [
      Fabricate(:message, :poster_id => user2.id),
      Fabricate(:image, :poster_id => user2.id),
      Fabricate(:link, :poster_id => user2.id)
    ]

    user2.items.each do |item|
      user.items.should_not include item
    end
  end

  describe "#subdomain" do
    it "returns the display name" do
      user.subdomain.should == user.display_name
    end
  end

  describe "is invalid with a" do
    let(:new_user) { Fabricate.build(:user) }

    after(:each) do
      new_user.errors[:display_name].should include 'is reserved'
    end

    describe "forbidden display name" do
      it "'www'" do
        new_user.display_name = 'www'
        new_user.should_not be_valid
      end

      it "'api'" do
        new_user.display_name = 'api'
        new_user.should_not be_valid
      end

      it "'nil'" do
        new_user.display_name = 'nil'
        new_user.should_not be_valid
      end
    end
  end
  context "subscriptions" do
    describe "#subscription" do
      let!(:twitter_subscription) {Fabricate(:subscription, provider: "twitter", user_id: user.id) }
      let!(:github_subscription) {Fabricate(:subscription, provider: "github", user_id: user.id) }
      it "returns the subscription of the provider type if it exists" do
        user.subscription("twitter").should == twitter_subscription
        user.subscription("github").should == github_subscription
        user.subscription("boo").should == nil
      end
    end
    describe "#num_subscriptions" do
      let!(:twitter_subscription) {Fabricate(:subscription, provider: "twitter", user_id: user.id) }
      let!(:github_subscription) {Fabricate(:subscription, provider: "github", user_id: user.id) }
      it "returns the number of subscriptions that exist" do
        user.num_subscriptions.should == 2
      end
    end
    describe "#subscribed_to_all_services?" do
      let!(:twitter_subscription) {Fabricate(:subscription, provider: "twitter", user_id: user.id) }
      it "returns false when not subscribed to all services" do
        github_subscription = Fabricate(:subscription, provider: "github", user_id: new_user.id)
        user.subscribed_to_all_services?.should == false
      end
      it "returns true when subscribed to all services" do
        github_subscription = Fabricate(:subscription, provider: "github", user_id: user.id)
        user.subscribed_to_all_services?.should == true
      end
    end
  end
end
