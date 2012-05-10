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
# == Schema Information
#
# Table name: growls
#
#  id                 :integer         not null, primary key
#  type               :string(255)
#  comment            :text
#  link               :text
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  user_id            :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

