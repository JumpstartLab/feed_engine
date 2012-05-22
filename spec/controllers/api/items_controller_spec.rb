require 'spec_helper'

describe Api::V1::ItemsController, :focus => true do
  render_views
  let!(:user) { Fabricate(:user) }

  describe "GET requests" do
    context "to index" do
      let(:params) {
        {
        :format       => :json,
        :display_name => user.display_name
      }
      }

      it "have the user's details" do
        get :index, params
        response.body.should have_content(user.id)
        response.body.should have_content(user.display_name)
        response.body.should have_content(api_v1_items_path(user.display_name))
      end

      context "without items" do
        it "shows page count of 0" do
          get :index, params
          response.body.should have_content(user.display_name)
          response.body.should_not have_content("pages: 0")
        end

        it "do not have paginated links" do
          get :index, params
          response.body.should have_content(user.display_name)
          response.body.should_not have_content("?page=1")
        end
      end

      context "with items" do
        let!(:message1) { Fabricate(:message, poster_id: user.id) }
        let!(:message2) { Fabricate(:message, poster_id: user.id) }
        let!(:message3) { Fabricate(:message, poster_id: user.id) }
        let!(:message4) { Fabricate(:message, poster_id: user.id) }

        it "the response is paginated" do
          get :index, params
          response.body.should have_content(user.post_page_count)
          response.body.should have_content("?page=1")
          response.body.should have_content("?page=#{user.post_page_count}")
        end

        it "have the post_type of the most recent post" do
          get :index, params
          response.body.should have_content("Message")
        end

        it "have the link of the most recent post" do
          get :index, params
          response.body.should have_content("/items/#{message4.item.id}")
        end

        it "do not include information about older posts" do
          get :index, params
          response.body.should_not have_content("/items/#{message1.item.id}")
        end

        it "contains only the most recent three item's details" do
          get :index, params
          parsed = JSON.parse(response.body)
          test_bodies = [message2, message3, message4].map(&:body)

          parsed["items"]["most_recent"].map { |item| item["body"] }.each do |body|
            test_bodies.should include body
            body.should_not == message1.body
          end
        end
      end
    end

    context "to show" do
      let!(:message) { Fabricate(:message) }
      let(:params) {
        {
        :format       => :json,
        :display_name => user.display_name,
        :id => message.item.id
      }
      }

      it "have the user's details" do
        get :show, params
        response.body.should have_content(user.id)
        response.body.should have_content(user.display_name)
        response.body.should have_content(api_v1_items_path(user.display_name))
      end

      it "have all the item details" do
        get :show, params
        item = JSON.parse(response.body)
        item["type"].should == "Message"
        item["id"].should == message.id
        item["body"].should == message.body
      end
    end

    describe "POST requests" do
      let!(:item) {
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

        it "persists a message for a user with correct attributes" do
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
end