require "spec_helper"
describe "/api/v1/projects", :type => :api do
    let(:user) { FactoryGirl.create(:user) }
    let(:token) { user.authentication_token }
    before(:each) do
      @image = FactoryGirl.create(:image, user: user, comment: "Woooo")
    end
    context "images viewable by this user" do
    let(:url) { "/api/v1/images" }
    it "json" do
      get "#{url}.json"
      images_json = user.images.to_json
      last_response.body.should eql(images_json)
      last_response.status.should eql(200)
    end
  end
end
