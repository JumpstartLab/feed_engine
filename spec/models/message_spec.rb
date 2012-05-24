# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  body       :text
#  poster_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  points     :integer         default(0)
#

require 'spec_helper'

describe Message do

  context "attributes" do
    let(:message){ Fabricate(:message) }

    it "is valid" do
      message.should be_valid 
    end

    it "is not valid without a poster" do
      message.poster_id = nil
      message.should_not be_valid
    end

    it "can be queried for the associated item" do
      message.item.should_not be_nil
    end

    context "for body" do
      it "must be non-empty" do
        message.body = ""
        message.should_not be_valid
      end
      it "must be under 513 characters" do
        message.body = ("X"*513)
        message.should_not be_valid
      end
      it "allows 512 characters" do
        max_body = ("X" * 512)
        max_body.length.should == 512
        message.body = max_body
        message.should be_valid
      end
    end
  end
end
