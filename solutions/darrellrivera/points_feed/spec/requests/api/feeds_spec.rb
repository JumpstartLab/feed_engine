require 'spec_helper'

describe 'Api Feeds' do
  let!(:user) { Fabricate(:user) }
  let!(:posts) {
    [
      Fabricate(:text_post, :user => user),
      Fabricate(:image_post, :user => user),
      Fabricate(:link_post, :user => user)
    ]
  }

  context 'user information' do
    before(:each) do
      visit api_feed_path(user.display_name, :format => :json)
      @json = JSON.parse(page.source)
    end

    it 'fetches the user display name' do
      @json['name'].should == user.display_name
    end

    it 'fetches the most recent text post' do
      @json['items']['most_recent'][0]['text'] == posts[0].content
    end

    it 'fetches the most recent image post' do
      @json['items']['most_recent'][1]['image_url'] == posts[1].content
    end

    it 'fetches the most recent link post' do
      @json['items']['most_recent'][2]['link_url'] == posts[2].content
    end
  end

  context 'items' do
    before(:each) do
      visit "/api/feeds/#{user.display_name}/items.json"
      @json = JSON.parse(page.source)
    end

    it 'has all the messages' do
      @json.count.should == posts.count
    end

    it 'has the text post' do
      content = posts[0].content.first
      page.body.should have_content(content)
    end

    it 'has the image post' do
      content = posts[1].content
      page.body.should have_content(content)
    end

    it 'has the link post' do
      content = posts[2].content
      page.body.should have_content(content)
    end
  end
end