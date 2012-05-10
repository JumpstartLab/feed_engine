require 'spec_helper'

describe "Feed" do
  messages = []
  5.times do |i|
     item =  FactoryGirl.create(:text_item)
     messages << item
  end

  describe "GET /" do
    it "has a feed page as root" do
      visit root_path
      page.should have_content "Your Feed"
    end
  end

  context "when I view the feed" do
    before(:each) do
      visit root_path
    end

    it "shows all the posts before the page max is reached" do
      messages.each do |message|
        page.should have_content(message.body)
      end
    end

    context "and there are more than 12 posts" do
      15.times do |i|
        item = FactoryGirl.create(:text_item)
        messages << item
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
end
