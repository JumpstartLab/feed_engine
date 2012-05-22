require 'spec_helper'

describe "Dashboard" do

  let(:authed_user) { FactoryGirl.create(:user) }

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

    describe "of link type" do
      describe "creating a link" do
        before(:each) do
          login(authed_user)
          visit dashboard_path
          click_on "Link"
        end

        it "prevents posting an invalid url", :js => true do
          fill_in "link_item[url]", :with => "adbc"
          click_on "Linkify"
          page.should have_content "enter a valid url"
        end

        it "prevents posting of a super long url", :js => true do
          bad_url = "http://google.com/#{'a' * 2049}"
          fill_in "link_item[url]", :with => bad_url
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


    #describe "of image type" do
      #describe "creating a image" do
        #before(:each) { click_on "Image"}

        #it "prevents posting an invalid url" do
          #fill_in "image_item[url]", :with => "adbc"
          #click_on "Imagify"
          #page.should have_content "must be jpg"
        #end

        #it "prevents posting an invalid image url" do
          #fill_in "image_item[url]", :with => "http://google.com"
          #click_on "Imagify"
          #page.should have_content "must be jpg"
        #end

        #it "prevents posting of a super long url" do
          #bad_url = "http://google.com/#{'a' * 2049}"
          #fill_in "image_item[url]", :with => bad_url
          #click_on "Imagify"
          #page.should have_content "is too long"
        #end

        #it "successfully adds valid links" do
          #good_url = "http://hungryacademy.com/images/beast.png"
          #fill_in "image_item[url]", :with => good_url
          #click_on "Imagify"
          #page.should have_content "Image was successfully created."
          #current_path.should == dashboard_path
        #end

        #it "adds the image to my feed" do
          #good_url = "http://google.com/foo.jpg"
          #fill_in "image_item[url]", :with => good_url
          #click_on "Imagify"
          #visit site_domain
          #page.should have_selector("img[src$='#{good_url}']")
        #end

        #describe "comments" do
          #before(:each) { fill_in "image_item[url]", :with => "http://hungryacademy.com/images/beast.png" }
          #it "prevents comments longer than 256 characters" do
            #fill_in "image_item[comment]", :with => "#{'a' * 257}"
            #click_on "Imagify"
            #page.should have_content "is too long"
          #end

          #it "successfully adds valid comments" do
            #fill_in "image_item[comment]", :with => "my awesome comment"
            #click_on "Imagify"
            #current_path.should == dashboard_path
          #end
        #end
      #end




    #describe "of link type" do
      #describe "creating a link" do
        #before(:each) { click_on "Link"}

        #it "prevents posting an invalid url" do
          #fill_in "link_item[url]", :with => "adbc"
          #click_on "Linkify"
          #page.should have_content "enter a valid url"
        #end

        #it "prevents posting of a super long url" do
          #bad_url = "http://google.com/#{'a' * 2049}"
          #fill_in "link_item[url]", :with => bad_url
          #click_on "Linkify"
          #page.should have_content "is too long"
        #end

        #it "successfully adds valid links" do
          #good_url = "http://google.com"
          #fill_in "link_item[url]", :with => good_url
          #click_on "Linkify"
          #page.should have_content "Link was successfully created."
          #current_path.should == dashboard_path
        #end

        #it "adds the new link to my feed" do
          #good_url = "http://google.com/test_link_for_feed"
          #fill_in "link_item[url]", :with => good_url
          #click_on "Linkify"
          #visit site_domain
          #page.should have_content good_url
        #end

        #describe "comments" do
          #before(:each) { fill_in "link_item[url]", :with => "http://google.com" }
          #it "prevents comments longer than 256 characters" do
            #fill_in "link_item[comment]", :with => "#{'a' * 257}"
            #click_on "Linkify"
            #page.should have_content "is too long"
          #end

          #it "successfully adds valid comments" do
            #fill_in "link_item[comment]", :with => "my awesome comment"
            #click_on "Linkify"
            #current_path.should == dashboard_path
          #end

        #end
      #end
    #end


    #describe "of image type" do
      #describe "creating a image" do
        #before(:each) { click_on "Image"}

        #it "prevents posting an invalid url" do
          #fill_in "image_item[url]", :with => "adbc"
          #click_on "Imagify"
          #page.should have_content "must be jpg"
        #end

        #it "prevents posting an invalid image url" do
          #fill_in "image_item[url]", :with => "http://google.com"
          #click_on "Imagify"
          #page.should have_content "must be jpg"
        #end

        #it "prevents posting of a super long url" do
          #bad_url = "http://google.com/#{'a' * 2049}"
          #fill_in "image_item[url]", :with => bad_url
          #click_on "Imagify"
          #page.should have_content "is too long"
        #end

        #it "successfully adds valid links" do
          #good_url = "http://hungryacademy.com/images/beast.png"
          #fill_in "image_item[url]", :with => good_url
          #click_on "Imagify"
          #page.should have_content "Image was successfully created."
          #current_path.should == dashboard_path
        #end

        #it "adds the image to my feed" do
          #good_url = "http://google.com/foo.jpg"
          #fill_in "image_item[url]", :with => good_url
          #click_on "Imagify"
          #visit site_domain
          #page.should have_selector("img[src$='#{good_url}']")
        #end

        #describe "comments" do
          #before(:each) { fill_in "image_item[url]", :with => "http://hungryacademy.com/images/beast.png" }
          #it "prevents comments longer than 256 characters" do
            #fill_in "image_item[comment]", :with => "#{'a' * 257}"
            #click_on "Imagify"
            #page.should have_content "is too long"
          #end

          #it "successfully adds valid comments" do
            #fill_in "image_item[comment]", :with => "my awesome comment"
            #click_on "Imagify"
            #current_path.should == dashboard_path
          #end
        #end
      #end
    #end
  #end
  #context "editing account" do 
    #before(:each) { visit "/dashboard" }
    #describe "edit" do
      #it "displays the form" do
        #page.should have_content "Change your password"
      #end
    #end
  #end
#end

