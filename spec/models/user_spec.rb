# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  display_name    :string(255)
#

require 'spec_helper'

describe User do
  describe "#subdomain" do
    let!(:user) { Fabricate(:user) } 
    it "returns the display name" do
      user.subdomain.should == user.display_name
    end
  end
end
