require 'spec_helper'

describe TextItem do
  it "requires a body" do
    test_item = TextItem.new(body:"")
    test_item.should_not be_valid
  end

  it "limits the length to 512 characters" do
    bad_body = "a" * 513
    test_item = TextItem.new(body:bad_body)
    test_item.should_not be_valid
  end

  it "creates a valid text item" do
    good_body = "a" * 512
    test_item = TextItem.new(body:good_body)
    test_item.should be_valid
  end

  context "#unique_id" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:text_item) { FactoryGirl.create(:text_item, :user => user) }
    it "returns the id for the stream item between the post and its author" do
      text_item.to_param.should == text_item.stream_items.where(user_id: text_item.user_id).first.id
    end
  end
end
