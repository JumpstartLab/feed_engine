require 'spec_helper'

describe Link do
  describe "#new" do
    let(:link) { Link.new(comment: "I love this site!", link: "http://www.hungryacademy.com") }

    context "when my link and comment are valid" do
      it "should be valid" do
        link.should be_valid
      end
    end

    context "when my link comment is longer than 256 characters" do
      it "should be invalid" do
        link.comment = 'a' * 257
        link.should_not be_valid
      end
    end

    context "when my link is blank" do
      it "should be invalid" do
        link.link = ''
        link.should_not be_valid
      end
    end

    context "when my link is greater than 2048 characters" do
      it "should be invalid" do
        link.link = link.link + ('a' * 2048)
        link.should_not be_valid
      end
    end

    context "when my link is of an improper format" do
      it "should be invalid" do
        link.link = 'abc123'
        link.should_not be_valid
      end
    end

    context "when my comment is 257 characters" do
      it "should be invalid" do
        link.comment = 'a' * 257
        link.should_not be_valid
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

