require 'spec_helper'


describe Post do
  describe "When I am creating a post as a signed-in user" do
    before(:each) do
      @user = Fabricate(:user)
      visit new_user_session_path
      fill_in "user_email", :with => "foo@bar.com"
      fill_in "user_password", :with => "hungry"
      click_button "Sign in"
      visit dashboard_path
    end

    it "allows me to create a new Text post", js: true do
      fill_in "post_content", with: "TextContent"
      click_button "Post"
      TextPost.count.should == 1
    end

    it "disallows me from creating a blank Text post" do
      click_button "Post"
      TextPost.count.should == 0
    end

  end
end