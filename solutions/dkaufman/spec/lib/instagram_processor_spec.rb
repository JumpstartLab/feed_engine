require 'fast_spec_helper'
require 'app/lib/instagram_processor.rb'
require 'active_support/core_ext/object/blank'

describe Hungrlr::InstagramProcessor do
  context ".run" do
    it "create instagram photos for a collection of users" do
      account = double
      account.stub(:[]).with("instagram_id").and_return("instagram_id")
      account.stub(:[]).with("token").and_return("token")
      account.stub(:[]).with("last_status_id").and_return("status_id")
      account.stub(:[]).with("user_id").and_return("user_id")
      api_service = double
      subject.stub(:api_service => api_service)

      subject.should_receive(:instagram_accounts).and_return([ account ])

      data = double
      Time.should_receive(:parse).and_return( "" )
      # Net::HTTP.should_receive(:get).and_return(data)
      # JSON.should_receive(:parse).with(data).and_return( { 'data' => [] } )
      subject.should_receive(:get_photos).and_return([])
      api_service.should_receive(:build_photos_hash).with([]).and_return([])
      api_service.should_receive(:create_photos_for_user).with("user_id", [])

      subject.run
    end
  end
end