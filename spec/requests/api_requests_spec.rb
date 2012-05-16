require 'spec_helper'

describe "API" do
  let(:user) { Fabricate(:user) }

  before(:each) do
    set_host("api")
  end

  after(:each) do
    reset_host
  end



  context "user's show page" do
    it "returns a 200" do
      get feed_path(user.display_name)
      response.code.should == '200'
    end
  end 
end