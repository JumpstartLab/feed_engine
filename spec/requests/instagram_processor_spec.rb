require 'spec_helper'
require 'ostruct'

describe Hungrlr::InstagramProcessor do
  context ".run" do
    before(:each) do
      # FactoryGirl.create(:user_with_twitter_account)
      Kernel.stub!(:open)
    end

    it "create photos for a collection of users" do
      Net::HTTP.should_receive(:get).and_return('        
        {"accounts":[{"user_id":1,"last_status_id":"2012-05-22T17:11:42-04:00","instagram_id":"17216354","token":"17216354.e8d1e46.269e7e21d652404f9607467db821d7d9"}]}')
      subject.should_receive(:get_photos).and_return(JSON.parse('{ "data": [ { "created_time": "1337634332", "id": "196413475740003380_17216354", "images": { "standard_resolution": { "url": "http://distilleryimage8.instagram.com/b3da7a60a38811e19e4a12313813ffc0_7.jpg" } } } ] }')["data"])

      Net::HTTP.should_receive(:post_form).once

      subject.run
    end
  end
end