require 'spec_helper'

describe Api::PostsController, :type => :api do
  let!(:user) { Fabricate(:user) }
  let!(:text_post) { Fabricate(:text_post, :user => user) }
  let!(:image_post) { Fabricate(:image_post, :user => user) }
  let!(:link_post) { Fabricate(:link_post, :user => user) }

  context '.show' do
    it 'has the text_post' do
      get "show", :id => text_post.id
      JSON.parse(response.body)['type'].should == "TextItem"
    end

    it 'has the image_post' do
      get "show", :id => image_post.id
      JSON.parse(response.body)['type'].should == "ImageItem"
    end

    it 'has the link_post' do
      get "show", :id => link_post.id
      JSON.parse(response.body)['type'].should == "LinkItem"
    end

    it 'has a invalid id' do
      get "show", :id => 100
      response.status.should == 400
    end
  end
end
