require 'spec_helper'

describe "Feed" do
  let!(:user) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user, :display_name => "test") }
  let!(:site_domain) { "http://#{user.display_name}.example.com" }

  context "points" do
    before(:each) do 
      login_factory_user(user.email)
      login(user)
      5.times do 
        text_item = FactoryGirl.create(:text_item, :user => user)
      end
      visit site_domain
    end
    
    it "adds a point for a logged in user" do
      t = user.text_items.first
      t_string = "a#item_#{t.id}"
      page.should have_selector(t_string)
      find(t_string).click
      t.points.count.should == 1
      page.should_not have_selector(t_string)
    end

    it "requres a user to be logged in" do
      click_on "Logout"
      t = user.text_items.first
      t_string = "a#item_#{t.id}"
      page.should have_selector(t_string)
      find(t_string).click
      page.should have_button('Log In')
    end

    it "adds a point for a user that logs in after clinking points" do
      click_on "Logout"
      t = user.text_items.first
      t_string = "a#item_#{t.id}"
      page.should have_selector(t_string)
      find(t_string).click
      page.should have_button('Log In')
      login_factory_user(user.email)
      login(user)
      visit site_domain  
      t.points.count.should == 1
      page.should_not have_selector(t_string)
    end
  end

  context "when a logged in user views the feed" do
    before(:each) do
      login_factory_user(user.email)
    end

    context "and there is less than 12 posts" do
      before(:each) do
        5.times do
          text_item = FactoryGirl.create(:text_item, :user => user)
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
          text_item = FactoryGirl.create(:text_item, :user => user)
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
        text_item = FactoryGirl.create(:text_item, :user => user_2)
      end
    end

    before(:each) do
      5.times do
        text_item = FactoryGirl.create(:text_item, :user => user)
      end
      visit site_domain
    end

    it "shows the posts by the user subdomain" do
      user.text_items.each do |item|
        page.should have_content(item.body)
      end
    end

    it "does not show posts by a different user" do
      page.should_not have_content(user_2.text_items.first)
    end
  end

  context "refeeds" do
    let!(:user_3) { FactoryGirl.create(:user) }
    let!(:user_3_domain) { "http://#{user_3.display_name}.example.com" }
    let!(:user_4) { FactoryGirl.create(:user) }
    let!(:user_4_domain) { "http://#{user_4.display_name}.example.com" }

    before(:each) do
      5.times do
        text_item = FactoryGirl.create(:text_item, :user => user_4)
      end
    end

    context "when a logged in user views another feed" do
      it "shows a button to refeed each post" do
        # VoodooDoubleLogin(tm)
        # login(user) is a devise helper to convince devise u are logged in
        # login_factory_user makes a post to sessions controller
        # in order to keep you logged in across subdomains
        # no one knows.
        login_factory_user(user_3.email)
        login(user_3)
        visit user_4_domain
        user_4.text_items.each do |item|
          within("#item_#{item.id}") do
            page.should have_css('.refeed_ajax_link')
          end
        end
      end

      # it "refeeds an item", :js => true do
      #   # login_factory_user(user_3.email)
      #   login(user_3)
      #   visit user_4_domain
      #   test_item = user_4.text_items.first
      #   within("#item_#{user_4.text_items.first.id}") { find(".refeed_ajax_link").click }
      #   page.should have_content("You retrouted")
      #   visit "http://#{user_3.display_name}.example.com"
      #   page.should have_content test_item.body
      # end
    end
  end
end
