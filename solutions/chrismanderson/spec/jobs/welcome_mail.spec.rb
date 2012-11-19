require 'spec_helper'

describe "welcomemailer" do
  let(:user) { FactoryGirl.create(:user) }

  it "sends an email" do
    UserMailer.should_receive(:welcome_email).with(@user)
    WelcomeMailJob.perform(user)

  end
end