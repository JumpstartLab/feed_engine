require 'spec_helper'
require 'ostruct'

describe Hungrlr::TweetProcessor do
  context ".run" do
    before(:each) do
      FactoryGirl.create(:user_with_twitter_account)
    end

    it "create tweets for a collection of users" do
      client = double
      Twitter::Client.should_receive(:new).and_return(client)
      Net::HTTP.should_receive(:get).and_return('
        {"accounts":[{"nickname":"wengzilla","last_status_id":"204779010281058304","user_id":1}]}')

      client.should_receive(:user_timeline).and_return(
        [ OpenStruct.new( id: "", text: "", source: "", created_at: "") ] )
      
      Net::HTTP.should_receive(:post_form).once

      subject.run
    end
  end
end