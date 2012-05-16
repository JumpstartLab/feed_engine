require 'spec_helper'

describe "API" do
  let(:user) { Fabricate(:user) }

  before(:each) do
    set_host("api")
  end

  after(:each) do
    reset_host
  end

  context "user's show page" do
    it "has the user's display name" do
      visit feed_path(user.display_name)
      page.should have_content(user.display_name)
    end

    it "has the user's id" do
      visit feed_path(user.display_name)
      page.should have_content(user.id)
    end

    it "has the user's api show link" do
      visit feed_path(user.display_name)
      page.should have_content(feed_path(user.display_name))
    end

    context "items" do
      it "has number of pages" do
        visit feed_path(user.display_name)
        page.should have_content(user.post_page_count)
      end

      context "if the user has no posts" do
        it "shows page count of 0" do
          visit feed_path(user.display_name)
          page.should_not have_content("pages: 0")
        end

        it "has none of the item information" do
          visit feed_path(user.display_name)
          page.should_not have_content("?page=1")
        end
      end

      context "if the user has posts" do
        let!(:message1) { Fabricate(:message, poster_id: user.id) }
        let!(:message2) { Fabricate(:message, poster_id: user.id) }
        let!(:message3) { Fabricate(:message, poster_id: user.id) }
        let!(:message4) { Fabricate(:message, poster_id: user.id) }
        it "has the first page" do
          visit feed_path(user.display_name)
          page.should have_content("?page=1")
        end

        it "has the last page" do
          visit feed_path(user.display_name)
          page.should have_content("?page=#{user.post_page_count}")
        end

        it "has the post_type of the most recent post" do
          visit feed_path(user.display_name)
          page.should have_content("Message")
        end

        it "has the link of the most recent post" do
          visit feed_path(user.display_name)
          page.should have_content("/items/#{message4.item.id}")
        end

        it "does not include information about older posts" do
          visit feed_path(user.display_name)
          page.should_not have_content("/items/#{message1.item.id}")
        end
      end
    end
  end 

  #Elise's pet - not required per stories
  context "item index" do
    context "when the user has items" do
      let!(:message) { Fabricate(:message, poster_id: user.id) }
      let!(:link) { Fabricate(:link, poster_id: user.id) }

      it "has the type of items created" do
        visit feed_item_index_path(user.display_name)
        page.should have_content("Message")
      end

      it "lists all items ever created" do
        visit feed_item_index_path(user.display_name)
        page.should have_content(message.body)
      end
      it "lists all items ever created" do
        visit feed_item_index_path(user.display_name)
        page.should have_content(link.url)
      end
    end
  end

  context "item show page" do
    let!(:message) { Fabricate(:message, poster_id: user.id) }
    let!(:link) { Fabricate(:link, poster_id: user.id) }

    context "when it is a message" do
      it "has the type of the item" do
        visit feed_item_path(:display_name => user.display_name,
                             :id => message.item.id)
        page.should have_content(message.body)
      end
      it "has the item's link" do
        visit feed_item_path(:display_name => user.display_name,
                             :id => message.item.id)
        page.should have_content("/items/#{message.item.id}")
      end
    end
    
    context "when it is a link" do
      it "has the url of the item" do
        visit feed_item_path(:display_name => user.display_name,
                             :id => link.item.id)
        page.should have_content(link.url)
      end
    end
  end
end