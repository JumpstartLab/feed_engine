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
      15.times do
        item = FactoryGirl.create(:text_item)
        messages << item
      end

      it "pages the posts when there are more than 12" do
        messages[0..11].each do |message|
          page.should have_content(message.body)
        end
        messages[12..-1].each do |message|
          page.should_not have_content(message.body)
        end
      end
    end
  end
end
