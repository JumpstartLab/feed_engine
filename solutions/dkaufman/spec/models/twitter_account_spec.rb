require 'spec_helper'

describe TwitterAccount do
  describe "#update_last_status_id_if_necessary(new_status_id)" do
    context "given an status id that is after the last_status_id" do  
      it "should update the last status id" do
        twitter_account = TwitterAccount.new(last_status_id: "203881099523395585")
        twitter_account.update_last_status_id_if_necessary("999999999999999999")
        twitter_account.last_status_id.should == "999999999999999999"
      end
    end

    context "given an status id that is before the last_status_id" do  
      it "should do nothing" do
        twitter_account = TwitterAccount.new(last_status_id: "203881099523395585")
        twitter_account.update_last_status_id_if_necessary("1")
        twitter_account.last_status_id.should == "203881099523395585"
      end
    end
  end
end
# == Schema Information
#
# Table name: twitter_accounts
#
#  id                :integer         not null, primary key
#  authentication_id :integer
#  uid               :integer
#  nickname          :string(255)
#  last_status_id    :string(255)     default("0"), not null
#  image             :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

