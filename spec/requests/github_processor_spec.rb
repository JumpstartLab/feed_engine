require 'spec_helper'
require 'ostruct'

describe Hungrlr::GithubProcessor do
  context ".run" do
    before(:each) do
      # FactoryGirl.create(:user_with_twitter_account)
    end

    it "create github events for a collection of users" do
      Octokit.should_receive(:user_events).and_return([ OpenStruct.new( type: "PushEvent", repo: OpenStruct.new( url: ""), created_at: "2013-05-22T18:28:59-04:00") ])
      Net::HTTP.should_receive(:get).and_return('
        {"accounts":[{"nickname":"eweng","last_status_id":"2012-05-22T18:28:59-04:00","user_id":1}]}')
      Net::HTTP.should_receive(:post_form).once
      subject.run
    end
  end
end