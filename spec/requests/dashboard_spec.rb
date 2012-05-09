require 'spec_helper'

describe "Dashboard" do
  describe "GET /dashboard" do
    it "has a dashboard page" do
      visit "/dashboard"
      page.should have_content "Dashboard"
    end
  end

  context "creating new posts" do
    before(:each) { visit "/dashboard" }
    describe "of text type" do
      it "displays the form" do
        page.should have_content "Create Text Post"
      end

      it "prevents creation of posts longer than 512 characters" do
        bad_body = "a" * 513
        fill_in "text_item[body]", :with => bad_body
        click_on "Textify"
        page.should have_content "is too long"
      end

      it "prevents creation of empty posts" do
        bad_body = ""
        fill_in "text_item[body]", :with => bad_body
        click_on "Textify"
        page.should have_content "can't be blank"
      end

      it "successfully adds a valid post" do
        valid_post = "I'm a valid post. Huzzah!"
        fill_in "text_item[body]", :with => valid_post
        click_on "Textify"
        page.should have_content valid_post
      end
    end

    describe "of link type" do
      it "has a link to make a new link" do
        click_on "Fiddl a link"
        page.should have_content "Post a link"
      end

      describe "creating a link" do
        before(:each) { click_on "Fiddl a link"}

        it "prevents posting an invalid url" do
          fill_in "link_item[url]", :with => "adbc"
          click_on "Linkify"
          page.should have_content "is invalid"
        end

        it "prevents posting of a super long url" do
          bad_url = "http://google.com/#{'a' * 2049}"
          fill_in "link_item[url]", :with => bad_url
          click_on "Linkify"
          page.should have_content "is too long"
        end

        it "successfully adds valid links" do
          good_url = "http://google.com"
          fill_in "link_item[url]", :with => good_url
          click_on "Linkify"
          page.should have_content good_url
          current_path.should == dashboard_path
        end

        describe "comments" do
          before(:each) { fill_in "link_item[url]", :with => "http://google.com" }
          it "prevents comments longer than 256 characters" do
            fill_in "link_item[comment]", :with => "#{'a' * 257}"
            click_on "Linkify"
            page.should have_content "is too long"
          end

          it "successfully adds valid comments" do
            fill_in "link_item[comment]", :with => "my awesome comment"
            click_on "Linkify"
            page.should have_content "my awesome comment"
            current_path.should == dashboard_path
          end
        end
      end

      
    end
  end
end