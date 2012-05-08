require 'spec_helper'

describe Link do
  describe "#new" do
    let(:link) { Link.new(comment: "Hi", link: "http://www.google.com") }

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
        link.link = 'http://www.google.com/' + ('a' * 2048)
        link.should_not be_valid
      end
    end

    context "when my link is of an improper format" do
      it "should be invalid" do
        link.link = 'abc123'
        link.should_not be_valid
      end
    end

  end
end
