require "spec_helper"
describe Growl do
  describe ".for_user(display_name)" do
    context "user exists" do
      context "user has growls" do
        let!(:user) { FactoryGirl.create(:user_with_growls) }
        it "returns an array of the user's growls" do
          Growl.for_user(user.username).should == user.growls
        end
      end
      context "user does not have growls" do
        let!(:user) { FactoryGirl.create(:user) }
        it "returns an empty array" do
          Growl.for_user(user.username).should == []
        end
      end
    end
    context "user does not exist" do
      it "should return nil" do
        Growl.for_user("user").should be_nil
      end
    end
  end
end
