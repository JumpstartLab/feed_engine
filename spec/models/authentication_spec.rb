require 'spec_helper'

describe Authentication do
  let(:user) { FactoryGirl.create(:user) }

  it "starts a job after creation" do
    a = Authentication.new
    a.should_receive(:initial_gathering)
    a.save!
  end

  context ".find_or_create_by_auth" do
    it "returns a user with the same Authentication" do
      auth = {'uid' => 1, 'info' => { 'image' => "image", 'description' => "hello", 'name' => "Chris", 'urls' => { 'Website' => "http://google.com" } } }
      puts auth['uid']
      Authentication.stub(:find_or_create_by_auth).with(auth).and_return(user)
      User.stub!(:find_or_create_by_uid).with( auth['uid'] ).and_return(user)
      Authentication.find_or_create_by_auth(auth).should == user
    end
  end

  it "does not save if already connected" do
    a = Authentication.create(:user_id => user.id, :provider => "twitter")
    b = Authentication.new(:user_id => user.id, :provider => "twitter" )
    b.should_not be_valid
  end
end
