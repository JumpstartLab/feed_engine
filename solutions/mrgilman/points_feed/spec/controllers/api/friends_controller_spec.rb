require 'spec_helper'

describe Api::FriendsController, :type => :api do
  let!(:user1) { Fabricate(:user) }
  let!(:user2) { Fabricate(:user, :email => 'two@two.com', :display_name => 'two') }

  it 'requires access token' do
    post "create", {
      :friend_id => user2.id
    }

    response.status.should == 403
  end

  context 'add a friend' do
    before(:each) do
      post "create", { 
        :access_token => user1.authentication_token,
        :friend_id => user2.id
      }
    end

    it 'is valid' do
      response.status.should == 201
    end

    it 'cannot add already existing friend' do
      post "create", {
        :access_token => user1.authentication_token,
        :friend_id => user2.id
      }

      user1.friends.length.should == 1
    end
  end
end
