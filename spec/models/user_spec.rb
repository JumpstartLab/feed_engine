require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  context "#send_welcome_message" do
    it "should call the UserMailer" do
      Mail::Message.any_instance.should_receive(:deliver)
      user.send_welcome_message
    end
  end

  context "#twitter_client" do
    context "if user has not linked his account with Twitter" do
      it "should return nil" do
        user.twitter_client.should == nil
      end
    end

    context "if user has linked his account with Twitter" do
      let!(:authentication) { user.authentications.create(provider: 'twitter') }
      it "should return a Twitter client instance" do
        user.authentications.where(provider: "twitter").first.should_not be_nil
        user.twitter_client.should be_kind_of(Twitter::Client)
      end
    end
  end
end# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  authentication_token   :string(255)
#  private                :boolean         default(FALSE)
#
