# require 'spec_helper'

# describe Api::V1::UsersController do
#   render_views

#   describe "GET requests for a user" do

#     let(:user) { Fabricate(:user) }
#     let(:params) {
#       {
#       :format       => :json,
#       :display_name => user.display_name
#       }
#     }

#     it "have the user's details" do
#       get :show, params
#       response.body.should have_content(user.id)
#       response.body.should have_content(user.display_name)
#       response.body.should have_content(api_v1_items_path(user.display_name))
#     end

#     context "without items" do
#       it "shows page count of 0" do
#         get :show, params
#         response.body.should_not have_content("pages: 0")
#       end

#       it "do not have paginated links" do
#         get :show, params
#         response.body.should_not have_content("?page=1")
#       end
#     end

#     context "with items" do
#       let!(:message1) { Fabricate(:message, poster_id: user.id) }
#       let!(:message2) { Fabricate(:message, poster_id: user.id) }
#       let!(:message3) { Fabricate(:message, poster_id: user.id) }
#       let!(:message4) { Fabricate(:message, poster_id: user.id) }

#       it "the response is paginated" do
#         get :show, params
#         response.body.should have_content(user.post_page_count)
#         response.body.should have_content("?page=1")
#         response.body.should have_content("?page=#{user.post_page_count}")
#       end

#       it "have the post_type of the most recent post" do
#         get :show, params
#         response.body.should have_content("Message")
#       end

#       it "have the link of the most recent post" do
#         get :show, params
#         response.body.should have_content("/items/#{message4.item.id}")
#       end

#       it "do not include information about older posts" do
#         get :show, params
#         response.body.should_not have_content("/items/#{message1.item.id}")
#       end
#     end
#   end
# end
