require 'spec_helper'

describe "Image Validations" do
  before(:each) { Image.any_instance.stub(:send_photo_to_amazon) }
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
          link = "http://image.com/image.png"
          image = Image.create(link: link)
          image.should_not be_valid
        end
      end
      
      context "allows creation without comment" do
        let(:link) { "http://www.justanimal.org/images/gorilla-10.jpg" }
        it "works with comment" do
          comment = "abc123"
          image = Image.new(link: link, comment: comment, user: FactoryGirl.create(:user))
          image.should be_valid
        end
        it "works without comment" do
          image = Image.new(link: link, user: FactoryGirl.create(:user))
          image.should be_valid
        end
        it "fails if comment is too long" do
          comment = "a" * 258
          image = Image.new(link: link, comment: comment, user: FactoryGirl.create(:user))
          image.should_not be_valid
        end
      end
    end
  end
end
