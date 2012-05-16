require 'spec_helper'

class PostableExample < ActiveRecord::Base
  include Postable
  self.table_name = 'messages'
end

describe Postable, :focus => true do
  let!(:postable_example) { PostableExample.new }

  it "creates a predicate method to check type" do
    postable_example.postable_example?.should be true
  end

  it "returns false if it is not of the correct class" do
    postable_example.message?.should be false
  end

  it "calls to method_missing? if the type is not postable" do
    lambda { postable_example.user? }.should raise_error NoMethodError
  end
end
