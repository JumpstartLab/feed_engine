require 'spec_helper'

describe InstagramAccount do
  describe "#update_last_status_id_if_necessary(new_status_id)" do
    context "given an status id that is after the last_status_id" do  
      it "should update the last status id" do
        instagram_account = InstagramAccount.new(last_status_id: "2011-12-28 14:55:58 -0500")
        instagram_account.update_last_status_id_if_necessary("2012-05-21T20:57:42-04:00")
        instagram_account.last_status_id.should == "2012-05-21T20:57:42-04:00"
      end
    end

    context "given an status id that is before the last_status_id" do  
      it "should do nothing" do
        instagram_account = InstagramAccount.new(last_status_id: "2011-12-28 14:55:58 -0500")
        instagram_account.update_last_status_id_if_necessary("2011-05-21T20:57:42-04:00")
        instagram_account.last_status_id.should == "2011-12-28 14:55:58 -0500"
      end
    end
  end
end
