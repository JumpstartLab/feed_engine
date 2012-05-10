# == Schema Information
#
# Table name: links
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Link do
  context "attributes" do
    let(:link){ Link.new(poster_id: 1, 
                           description: "wow",
                           url: "http://wow.com" ) }

    it "is valid" do
      link.should be_valid 
    end

    it "uses ExternalContent" do
      Link.ancestors.should include(ExternalContent)
    end

    context "for description" do
      it "must be under 257 characters" do
        link.description = ("X"*257)
        link.should_not be_valid
      end
      it "allows 256 characters" do
        link.description = ("X"*256)
        link.should be_valid
      end
    end

    it "is not valid without a poster" do
      link.poster_id = nil
      link.should_not be_valid
    end

    context "for url" do
      it "must be non-empty" do
        link.url = ""
        link.should_not be_valid
      end
      it "must be under 2049 characters" do
        link.url = ("X"*2049)
        link.should_not be_valid
      end
      it "allows 2048 characters" do
        max_url = ("http://example.com/" + "X" * 2029)
        max_url.length.should == 2048
        link.url = max_url
        link.should be_valid
      end
      it "must be a valid uri" do
        link.url = "wow.com"
        link.should_not be_valid
      end
    end
  end
end
