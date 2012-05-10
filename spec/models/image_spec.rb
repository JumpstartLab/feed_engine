require 'spec_helper'

describe Image do
  describe "#new" do
    context "Validations" do
      it "When my message is longer then 256 characters" do
        link = 'a' * 256
        image = Image.new(link: link)
        image.should_not be_valid
      end
      context "Link errors" do
        it "must have http" do
          link = "abc123"
          image = Image.create(link: link)
          image.should_not be_valid
        end
        it "must be less then 2048 characters" do
          link = "a" * 2049
          image = Image.create(link: link)
          image.should_not be_valid
        end
        it "must be a valid image" do
          link = "http://poop.com/poop.png"
          image = Image.create(link: link)
          image.should_not be_valid
        end
      end
      context "allows creation without comment" do
        let(:link) { "http://www.justanimal.org/images/gorilla-10.jpg" }
        it "works with comment" do
          comment = "abc123"
          image = Image.create(link: link, comment: comment)
          image.should be_valid
        end
        it "works without comment" do
          image = Image.create(link: link)
          image.should be_valid
        end
        it "fails if comment is too long" do
          comment = "a" * 258
          image = Image.create(link: link, comment: comment)
          image.should_not be_valid
        end
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

