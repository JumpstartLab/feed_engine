require 'spec_helper'

describe Api::FeedsController, :type => :api do
  let!(:user1) { Fabricate(:user) }
  let!(:user2) { Fabricate(:user, :email => 'two@two.com', :display_name => 'two') }
  let!(:text_post) { Fabricate(:text_post, :user => user1) }
  
  it 'cannot be accessed by visitor' do
    post "refeed", {
      :item_id => text_post.id,
      :id => user1.display_name
    }

    response.status.should == 403
  end

  it 'post can be refeeded' do
    post "refeed", {
      :access_token => user2.authentication_token,
      :item_id => text_post.id,
      :id => user1.display_name
    }

    response.status.should == 201
  end
end
