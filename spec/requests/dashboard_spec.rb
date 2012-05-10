require 'spec_helper'

describe "Dashboard" do

  let!(:user) { FactoryGirl.create(:user) }
  before(:each) do
    login_factory_user
  end

  describe "GET /dashboard" do
    it "has a dashboard page" do
      visit "/dashboard"
      page.should have_content "Dashboard"
    end
  end

  context "creating new posts" do
    before(:each) { visit "/dashboard" }
    describe "of text type" do

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
        page.should have_content "Post was successfully created."
      end
    end

    describe "of link type" do
      describe "creating a link" do
        before(:each) { click_on "Link"}

        it "prevents posting an invalid url" do
          fill_in "link_item[url]", :with => "adbc"
          click_on "Linkify"
          page.should have_content "http/https"
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
          page.should have_content "Link was successfully created."
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
            current_path.should == dashboard_path
          end
        end
      end
    end
    describe "of image type" do
      describe "creating a image" do
        before(:each) { click_on "Image"}

        it "prevents posting an invalid url" do
          fill_in "image_item[url]", :with => "adbc"
          click_on "Imagify"
          page.should have_content "must be jpg"
        end

        it "prevents posting an invalid image url" do
          fill_in "image_item[url]", :with => "http://google.com"
          click_on "Imagify"
          page.should have_content "must be jpg"
        end

        it "prevents posting of a super long url" do
          bad_url = "http://google.com/#{'a' * 2049}"
          fill_in "image_item[url]", :with => bad_url
          click_on "Imagify"
          page.should have_content "is too long"
        end

        it "successfully adds valid links" do
          good_url = "http://hungryacademy.com/images/beast.png"
          fill_in "image_item[url]", :with => good_url
          click_on "Imagify"
          page.should have_content "Image was successfully created."
          current_path.should == dashboard_path
        end

        describe "comments" do
          before(:each) { fill_in "image_item[url]", :with => "http://hungryacademy.com/images/beast.png" }
          it "prevents comments longer than 256 characters" do
            fill_in "image_item[comment]", :with => "#{'a' * 257}"
            click_on "Imagify"
            page.should have_content "is too long"
          end

          it "successfully adds valid comments" do
            fill_in "image_item[comment]", :with => "my awesome comment"
            click_on "Imagify"
            current_path.should == dashboard_path
          end
        end
      end
    end
  end
end
