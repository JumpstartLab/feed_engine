require 'spec_helper'

describe "Dashboard" do

  let!(:authed_user) { FactoryGirl.create(:user) }
  let!(:site_domain) { "http://#{authed_user.display_name}.example.com" }

  context "visiting the dashboard" do
    it "requires login" do
      visit dashboard_path
      page.should have_content "You need to sign in"
    end

    context "when user is logged in" do
      it "loads when a user is logged in" do
        login(authed_user)
        visit dashboard_path
        page.should have_content "Dashboard"
      end

      it "exits a subdomain" do
        visit site_domain
        login(authed_user)
        visit dashboard_path
        uri = URI.parse(current_url)
        current_url.should == "http://example.com/dashboard"
      end
    end
  end
  
  context "creating new posts" do
    describe "of text type" do
      it "prevents creation of posts longer than 512 characters", :js => true do
        login(authed_user)
        visit dashboard_path
        page.should have_content "Dashboard"
        bad_body = "a" * 513
        fill_in "text_item[body]", :with => bad_body
        click_on "Textify"
        page.should have_content "is too long"
      end

      it "prevents creation of empty posts", :js => true do
        login(authed_user)
        visit dashboard_path
        bad_body = ""
        fill_in "text_item[body]", :with => bad_body
        click_on "Textify"
        page.should have_content "can't be blank"
      end

      it "successfully adds a valid post", :js => true do
        login(authed_user)
        visit dashboard_path
        valid_post = "I'm a valid post. Huzzah!"
        fill_in "text_item[body]", :with => valid_post
        click_on "Textify"
        page.should have_content "Post was successfully created."
      end

      it "adds the new post to my feed", :js => true do
        login(authed_user)
        visit dashboard_path
        valid_post = "New post for feed test!"
        fill_in "text_item[body]", :with => valid_post
        click_on "Textify"
        page.should have_content valid_post
      end
    end

    describe "of image type" do
      describe "creating a image" do
        it "prevents posting an invalid url", :js => true  do
          login(authed_user)
          visit dashboard_path
          fill_in "image_item_url", :with => "adbc"
          click_on "Imagify"
          page.should have_content "must be jpg"
        end

        it "prevents posting an invalid image url", :js => true  do
          login(authed_user)
          visit dashboard_path
          fill_in "image_item_url", :with => "http://google.com"
          click_on "Imagify"
          page.should have_content "must be jpg"
        end

        it "prevents posting of a super long url", :js => true  do
          login(authed_user)
          visit dashboard_path
          bad_url = "http://google.com/#{'a' * 2049}"
          fill_in "image_item_url", :with => bad_url
          click_on "Imagify"
          page.should have_content "is too long"
        end

        it "successfully adds valid links", :js => true  do
          login(authed_user)
          visit dashboard_path
          good_url = "http://hungryacademy.com/images/beast.png"
          fill_in "image_item_url", :with => good_url
          click_on "Imagify"
          page.should have_content "Post was successfully created."
          current_path.should == dashboard_path
        end

        it "adds the image to my feed", :js => true  do
          login(authed_user)
          visit dashboard_path
          good_url = "http://google.com/foo.jpg"
          fill_in "image_item_url", :with => good_url
          click_on "Imagify"
          page.should have_selector("img[src$='#{good_url}']")
        end

        describe "comments" do
          it "prevents comments longer than 256 characters", :js => true  do
            login(authed_user)
            visit dashboard_path
            fill_in "image_item_url", :with => "http://hungryacademy.com/images/beast.png"
            fill_in "image_item_comment", :with => "#{'a' * 257}"
            click_on "Imagify"
            page.should have_content "is too long"
          end

          it "successfully adds valid comments", :js => true  do
            login(authed_user)
            visit dashboard_path
            fill_in "image_item_url", :with => "http://hungryacademy.com/images/beast.png"
            fill_in "image_item_comment", :with => "my awesome comment"
            click_on "Imagify"
            current_path.should == dashboard_path
          end
        end
      end
    end

    describe "of link type" do
      describe "creating a link" do
        before(:each) do
          login(authed_user)
          visit dashboard_path
          click_on "Link"
        end

        it "prevents posting an invalid url", :js => true do
          fill_in "link_item_url", :with => "adbc"
          click_on "Linkify"
          page.should have_content "enter a valid url"
        end

        it "prevents posting of a super long url", :js => true do
          bad_url = "http://google.com/#{'a' * 2049}"
          fill_in "link_item_url", :with => bad_url
          click_on "Linkify"
          page.should have_content "is too long"
        end

        it "successfully adds valid links", :js => true do
          good_url = "http://google.com"
          fill_in "link_item[url]", :with => good_url
          click_on "Linkify"
          page.should have_content "Post was successfully created."
          current_path.should == dashboard_path
        end

        it "adds the new link to my feed", :js => true do
          good_url = "http://google.com/test_link_for_feed"
          fill_in "link_item[url]", :with => good_url
          click_on "Linkify"
          page.should have_content good_url
        end

        describe "comments" do
          before(:each) { fill_in "link_item[url]", :with => "http://google.com" }
          it "prevents comments longer than 256 characters", :js => true do
            fill_in "link_item[comment]", :with => "#{'a' * 257}"
            click_on "Linkify"
            page.should have_content "is too long"
          end

          it "successfully adds valid comments", :js => true do
            fill_in "link_item[comment]", :with => "my awesome comment"
            click_on "Linkify"
            current_path.should == dashboard_path
          end
        end
      end
    end
  end
end
