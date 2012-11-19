require 'spec_helper'

describe Video do
  let(:user) { FactoryGirl.create(:user) }

  describe "Creating a video" do
    before(:each) do
      login(user)
      visit dashboard_path
    end

    it "can create a video" do
      within ("#video_form") do
        fill_in "growl[link]", with: "http://youtu.be/DRVvFYppU0w"
        fill_in "growl[comment]", with: "woooooo"
        click_link_or_button "Growl Video"
      end
      page.should have_content "Your video has been created"
    end

    context "no link" do
      it "fails" do
        within ("#video_form") do
          fill_in "growl[link]", :with => ""
          fill_in "growl[comment]", :with => "FOO Manchu!"
          click_on "Growl Video"
        end
        page.should have_content "You must provide a YouTube link"
      end
    end
  end
end