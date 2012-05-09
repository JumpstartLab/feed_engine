require 'spec_helper'

describe Message do
  let(:message) { Message.new(comment: "A witty joke") }

  describe "#new" do
    context "when my message is valid" do
      it "should be valid" do
        message.should be_valid
      end
    end

    context "when my message is longer than 512 characters" do
      it "should be invalid" do
        comment = 'a' * 513
        message = Message.new(comment: comment)
        message.should_not be_valid
      end
    end

    context "when my message is blank" do
      it "should be invalid" do
        comment = ''
        message = Message.new(comment: comment)
        message.should_not be_valid
      end
    end
  end
end
