require 'spec_helper'

describe "Feed" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:site_domain) { "http://#{user.display_name}.example.com" }

  context "when a logged in user views the feed" do
    before(:each) do
      login_factory_user(user.email)
    end

    context "and there is less than 12 posts" do
      before(:each) do
        5.times do 
          text_item = FactoryGirl.create(:text_item)
          user.text_items << text_item
          user.add_stream_item(text_item)
        end
        visit site_domain
      end

      it "shows all the posts before the page max is reached" do
        user.text_items.each do |item|
          page.should have_content(item.body)
        end
      end
    end

    context "and there are more than 12 posts" do
      before(:each) do
        15.times do 
          text_item = FactoryGirl.create(:text_item)
          user.text_items << text_item
          user.add_stream_item(text_item)
        end
        visit site_domain
      end

      it "pages the posts when there are more than 12" do
        within(".pagination") do
          page.should have_content("2")
          page.should have_content("Next")
          page.should have_content("Last")
        end
      end
    end
  end

  context "when a visitor views a feed" do
    let!(:user_2) { FactoryGirl.create(:user) }

    before(:each) do
      5.times do 
        text_item = FactoryGirl.create(:text_item)
        user_2.text_items << text_item
        user_2.add_stream_item(text_item)
      end
    end

    before(:each) do
      5.times do 
        text_item = FactoryGirl.create(:text_item)
        user.text_items << text_item
        user.add_stream_item(text_item)
      end
      visit site_domain
    end

    it "shows the posts by the user subdomain" do
      user.text_items.each do |item|
        page.should have_content(item.body)
      end
    end

    it "has the user as the title" do
      find('h1').should have_content user.display_name
    end
  end
end
