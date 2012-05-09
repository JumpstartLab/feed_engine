require 'spec_helper'


describe Post do
  describe "When I am creating a post as a signed-in user" do
    before(:each) do
      @user = Fabricate(:user)
      visit signin_path
      fill_in "Email", :with => "foo@bar.com"
      fill_in "Password", :with => "hungry"
      click_button "Sign in"
      visit new_post_path
    end

    it "allows me to create a new Text post" do
      fill_in "Title", with: "TextTitle"
      fill_in "Content", with: "TextContent"
      choose "post_type_textpost"
      click_button "Save Post"
      TextPost.count.should == 1
    end

    it "disallows me from creating a blank Text post" do
      fill_in "Title", with: "TextTitle"
      choose "post_type_textpost"
      click_button "Save Post"
      TextPost.count.should == 0
    end

  end
end