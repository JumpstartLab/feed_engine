require 'spec_helper.rb'
describe Growl do
  describe "#new" do
    let!(:user) { FactoryGirl.create(:user_with_growls) }
    it "defaults original created date to the current date" do
      user.growls.each do |growl|
        growl.original_created_at.should_not be_nil
      end
    end
  end
end