require 'spec_helper'

describe "Feed" do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_factory_user
  end

  context "when I view the feed" do
    context "and there is less than 12 posts" do
      before(:each) do
        5.times do 
          text_item = FactoryGirl.create(:text_item)
          user.text_items << text_item
          user.add_stream_item(text_item)
        end
        visit root_path
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
        visit root_path
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
