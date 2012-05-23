require 'spec_helper'

describe "When I refeed via the API", :type => :api do
  let!(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:text_item) { FactoryGirl.create(:text_item, :user => user, :body => "user 1's fantastic text post!") }
  let(:url) { "http://api.example.com#{api_refeed_item_path(user, text_item)}" }

  before do
    @client = Pusher::Client.new({
      :app_id => '20',
      :key => '12345678900000001',
      :secret => '12345678900000001',
      :host => 'api.pusherapp.com',
      :port => 80,
    })
    @client.encrypted = false

    WebMock.reset!
    WebMock.disable_net_connect!

    @pusher_url_regexp = %r{/apps/20778/channels/test_channel/events}
  end
  describe "refeed" do
    before :each do
      WebMock.stub_request(:post, @pusher_url_regexp).
        to_return(:status => 202)
      @channel = @client['test_channel']
    end
    it "adds the item to my feed" do


    post "#{url}.json", :token => user2.authentication_token
    user2.stream_items.last.streamable.should == text_item
    user2.stream_items.last.refeed.should == true
  end

  context "and I try to refeed my own item" do
    let(:user2_text_item) { FactoryGirl.create(:text_item, user: user2, body: "user 2's text item") }
    let(:url) { "http://api.example.com#{api_refeed_item_path(user2, user2_text_item)}" }

    it "prevents me from refeeding the item" do
      post "#{url}.json", :token => user2.authentication_token
      last_response.status.should == 400
    end
  end
  end
end

