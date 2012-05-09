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
end
