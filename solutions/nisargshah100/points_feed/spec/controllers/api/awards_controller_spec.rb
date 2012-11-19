require 'spec_helper'

describe Api::AwardsController do

  context "user awards point to a text item", :type => :api do
    let!(:user) { Fabricate(:user) }
    let!(:text_post) { Fabricate(:text_post, :user_id => 1) }

    it 'creates a point' do
      post "create", {
        :access_token => user.authentication_token,
        :awardable_id => text_post.id,
        :awardable_type => "Post"
      }

      response.status.should == 201
    end
  end

end
