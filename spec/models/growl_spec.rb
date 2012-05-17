require 'spec_helper.rb'
describe Growl do
  describe "#new" do
    let!(:growl) { Fabricate(:growl) }
    it "defaults original created date to the current date" do
      growl.original_created_at.should_not be_nil
    end
  end
end