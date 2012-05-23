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

    it "clicks refeed and does not see a duplicate item in the root feed" do
      message = Message.find_by_poster_id(other_user.id)
      set_host(other_user.display_name)
      visit root_path
      find("#refeed_item_#{message.item.id}").click
      reset_host
      visit root_path
      page.should_not have_selector("#item_#{message.item.id}", :count => 2)
    end
    context "refeeds another feed from another user's feed" do
      let!(:other_user) { Fabricate(:user) }
      before(:each) do
        set_host other_user.subdomain
        visit root_path
      end
      it "shows a link to refeed" do
        page.should have_link "Refeed"
      end
      it "creates a subscription for the other user's feed" do
        expect { click_link_or_button "Refeed" }.to change { user.subscriptions.count }.by(1)
        user.subscriptions.last.provider.should == "refeed"
        user.subscriptions.last.uid.should == other_user.id.to_s
      end
      context "and a refeed subscription has already been created" do
        before(:each) do
          click_link_or_button "Refeed"
        end

        it "does not show a link to refeed" do
          set_host other_user.subdomain
          visit root_path
          page.should_not have_link "Refeed"
        end
      end
      context "and an item has been refeeded" do

        it "shows the item on the user's feed" do
          random_body_type = ["message", "tweet", "instapound"].sample
          body_post = Fabricate(random_body_type.to_sym, :poster_id => other_user.id)

          random_description_type = ["image", "link"].sample
          description_post = Fabricate(random_description_type.to_sym, :poster_id => other_user.id)

          body_post.item.refeed_for(user)
          description_post.item.refeed_for(user)

          set_host(user.subdomain)
          visit root_path

          page.should have_content body_post.body
          page.should have_content description_post.description
        end
      end
    end
  end
end
