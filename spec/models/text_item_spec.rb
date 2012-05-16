require 'spec_helper'

describe TextItem do
  let(:user) { FactoryGirl.create(:user) }
  it "requires a body" do
    test_item = TextItem.new(body:"", :user => user)
    test_item.should_not be_valid
  end

  it "limits the length to 512 characters" do
    bad_body = "a" * 513
    test_item = TextItem.new(body:bad_body, :user => user)
    test_item.should_not be_valid
  end

  it "creates a valid text item" do
    good_body = "a" * 512
    test_item = TextItem.new(body:good_body, :user => user)
    test_item.should be_valid
  end

  it "requires a user to save" do
    test_item = TextItem.new(body:"hello")
    test_item.should_not be_valid
  end

  it "adds the item to the author's feed" do
    test_item = TextItem.new(body:"hello I am a test", :user => user)
    test_item.save
    user.stream_items.last.streamable.should == test_item
    user.stream_items.last.refeed.should == false
  end

  it "adds the item to the author's feed" do
    test_item = TextItem.new(body:"hello I am a test", :user => user)
    test_item.save
    user.stream_items.last.streamable.should == test_item
    user.stream_items.last.refeed.should == false
  end

  context "#to_param" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:text_item) { FactoryGirl.create(:text_item, :user => user) }
    it "returns the id for the stream item between the post and its author" do
      text_item.to_param.should == text_item.stream_items.where(user_id: text_item.user_id).first.id
    end
  end
end
