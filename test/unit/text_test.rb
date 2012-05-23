require 'minitest_helper'

describe Text do
  it "creates a new Link record on create" do
    text = Text.create(:content => "one two three 123~!")
    assert_equal text.valid?, true
    assert_equal text.content, "one two three 123~!"
  end
  
  it "rejects Text records without a content value" do
    text = Link.create
    assert_equal text.valid?, false
  end
  
  it "rejects content longer than 512 characters" do
    text = Link.create(:content => "a"*513)
    assert_equal text.valid?, false
  end
end