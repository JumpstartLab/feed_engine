# == Schema Information
#
# Table name: images
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Image do
  context "attributes" do
    let(:image){ Image.new(poster_id: 1, 
                           description: "wow",
                           url: "http://wow.com/wow.jpg" ) }

    it "is valid" do
      image.should be_valid 
    end

    it "uses ExternalContent" do
      Image.ancestors.should include(ExternalContent)
    end

    context "for description" do
      it "must be under 257 characters" do
        image.description = ("X"*257)
        image.should_not be_valid
      end
      it "allows 256 characters" do
        image.description = ("X"*256)
        image.should be_valid
      end
    end

    it "is not valid without a poster" do
      image.poster_id = nil
      image.should_not be_valid
    end

    context "for url" do
      it "must be non-empty" do
        image.url = ""
        image.should_not be_valid
      end
      it "must be under 2049 characters" do
        image.url = ("X"*2049)
        image.should_not be_valid
      end
      it "allows 2048 characters" do
        max_url = ("http://example.com/" + "X" * 2025 + ".jpg")
        max_url.length.should == 2048
        image.url = max_url
        image.should be_valid
      end
      it "must be a valid uri" do
        image.url = "wow.com"
        image.should_not be_valid
      end
      it "must be a valid image type" do
        image.url = "http://wow.com/wow.html"
        image.should_not be_valid
      end
      [".jpg", ".jpeg", ".gif", ".bmp", ".png"].each do |extension|
        it "allows files with #{extension}" do
          image.url = "http://wow.com/wow#{extension}"
          image.should be_valid
        end
      end
    end
  end
end
