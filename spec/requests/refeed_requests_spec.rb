require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user_with_posts) }
  let(:other_user) { Fabricate(:user_with_posts) }

  context "who is not authenticated" do
    before(:all) do
      logout
    end

    it "does not see refeed links" do
      visit root_path
      page.should_not have_link "Refeed"
    end
  end

  context "who is authenticated" do
    before(:each) do
      reset_host
      login_as(user)
      visit root_path
    end

    after(:each) do
      reset_host
    end

    it "sees refeed links for other user's items" do
      set_host(other_user.display_name)
      visit root_path
      find(".#{other_user.display_name}_post").should have_link "Refeed"
    end

    it "does not see refeed links for their own items" do
      find(".#{user.display_name}_post").should_not have_link "Refeed"
    end

    it "does not see refeed links for items they've already refed" do
      message = Message.find_by_poster_id(other_user.id)
      set_host(other_user.display_name)
      visit root_path
      find("#refeed_item_#{message.item.id}").click
      page.should_not have_link "refeed_item_#{message.item.id}"
    end

    it "clicks refeed and sees the refed item in their feed" do
      message = Message.find_by_poster_id(other_user.id)
      set_host(other_user.display_name)
      visit root_path
      find("#refeed_item_#{message.item.id}").click
      set_host(user.display_name)
      visit root_path
      page.should have_content message.body
    end
  end
end
