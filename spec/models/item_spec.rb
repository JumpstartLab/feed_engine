require 'spec_helper'

describe Item, :focus => true do
  it "has a user" do
    subject.should respond_to :user
  end

  it "is created when an image is created" do
    image = Image.create
    image.item.should_not be_nil
  end
end
