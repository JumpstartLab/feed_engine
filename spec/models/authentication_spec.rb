require 'spec_helper'

describe Authentication do
  let(:user) { FactoryGirl.create(:user) }

  it "starts a job after creation" do
    a = Authentication.new
    a.should_receive(:initial_gathering)
    a.save!
  end

  it "does not save if already connected" do
    a = Authentication.create(:user_id => user.id, :provider => "twitter")
    b = Authentication.new(:user_id => user.id, :provider => "twitter" )
    b.should_not be_valid
  end
end
