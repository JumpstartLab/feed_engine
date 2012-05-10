require 'spec_helper'


describe Post do
  describe "When I am creating a post as a signed-in user" do
    before(:each) do
      @user = Fabricate(:user)
      visit signin_path
      fill_in "Email", :with => "foo@bar.com"
      fill_in "Password", :with => "hungry"
      click_button "Sign in"
      visit dashboard_path
    end

    it "allows me to create a new Text post" do
      fill_in "post[title]", with: "TextTitle"
      fill_in "post[content]", with: "TextContent"
      click_button "Post"
      TextPost.count.should == 1
    end

    it "disallows me from creating a blank Text post" do
      fill_in "post[title]", with: "TextTitle"
      click_button "Post"
      TextPost.count.should == 0
    end

  end
end