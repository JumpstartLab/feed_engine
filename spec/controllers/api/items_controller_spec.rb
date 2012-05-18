require 'spec_helper'

describe Api::V1::ItemsController do
  let(:user) { Fabricate(:user) }

  # describe "GET requests" do
  #   context "item index" do
  #     context "when the user has items" do
  #       let!(:message) { Fabricate(:message, poster_id: user.id) }
  #       let!(:link) { Fabricate(:link, poster_id: user.id) }

  #       it "has the type of items created" do
  #         visit api_v1_items_path(user.display_name) + '.json'
  #         page.should have_content("Message")
  #       end

  #       it "lists all items ever created" do
  #         visit api_v1_items_path(user.display_name) + '.json'
  #         page.should have_content(message.body)
  #       end
  #       it "lists all items ever created" do
  #         visit api_v1_items_path(user.display_name) + '.json'
  #         page.should have_content(link.url)
  #       end
  #     end
  #   end

  #   context "item show page" do
  #     let!(:message) { Fabricate(:message, poster_id: user.id) }
  #     let!(:link) { Fabricate(:link, poster_id: user.id) }

  #     context "when it is a message" do
  #       it "has the type of the item" do
  #         visit api_v1_item_path(:display_name => user.display_name,
  #                              :id => message.item.id) + '.json'
  #         page.should have_content(message.body)
  #       end
  #       it "has the item's link" do
  #         visit api_v1_item_path(:display_name => user.display_name,
  #                              :id => message.item.id) + '.json'
  #         page.should have_content("/items/#{message.item.id}")
  #       end
  #     end

  #     context "when it is a link" do
  #       it "has the url of the item" do
  #         visit api_v1_item_path(:display_name => user.display_name,
  #                              :id => link.item.id) + '.json'
  #         page.should have_content(link.url)
  #       end
  #     end
  #   end
  # end

  describe "POST requests" do
    let(:item) {
      {
        :format       => :json,
        :display_name => user.display_name,
        :api_key      => user.api_key,
        :post         => { 'type' => 'message', 'body' => 'Lovebuckets!' }
      }
    }

    it "without a valid user token responds with unauthorized" do
      item[:api_key] = nil
      post :create, item
      response.code.should == '401'
    end

    describe "with a valid user token" do
      it "responds with Unprocessable Entity without a post" do
        item[:post] = nil
        post :create, item
        response.code.should == '422'
      end

      it "creates an item" do
        Item.should_receive :create
        post :create,
             :format => :json,
             :display_name => user.display_name,
             :api_key => user.api_key,
             :post => { 'type' => 'message',
                        'body' => 'Lovebuckets!'}
      end

      it "persists a message for a user with correct attributes", :focus => true do
        post :create,
             :format => :json,
             :display_name => user.display_name,
             :api_key => user.api_key,
             :post => { 'type' => 'message',
                        'body' => 'Lovebuckets!'}

        message = Message.first
        user.posts.should include message
        message.body.should == 'Lovebuckets!'
      end
    end
  end
end
