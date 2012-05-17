require 'spec_helper'

class PostableExample < ActiveRecord::Base
  include Postable
  self.table_name = 'messages'
end

class OtherPostableExample < ActiveRecord::Base
  include Postable
  self.table_name = 'messages'
end

describe Postable do
  let!(:postable_example) { PostableExample.new }
  let!(:other_postable_example) { OtherPostableExample.new }

  it "creates a predicate method to check type" do
    postable_example.postable_example?.should be true
  end

  it "returns false if it is not of the correct class" do
    postable_example.message?.should be false
  end

  it "calls to method_missing? if the type is not postable" do
    lambda { postable_example.user? }.should raise_error NoMethodError
  end

  it "responds to :other_postable_example?" do
    postable_example.should respond_to :other_postable_example?
  end

  it "responds to :postable_example?" do
    other_postable_example.should respond_to :postable_example?
  end

  it "does not respond to :user?" do
    postable_example.should_not respond_to :user?
  end

  it "does not respond to random predicate methods" do
    seuss = %w(one fish two fish red fish blue fish)
    seuss.each { |meth| postable_example.should_not respond_to "#{meth}?".to_sym }
  end

  describe "#local_created_at" do
    it "returns the local time of the post" do
      random_post_type = ["message", "link", "github_event", "tweet", "image"].sample
      random_post = Fabricate(random_post_type.to_sym)
      random_post.local_created_at.should == random_post.created_at.localtime
    end
  end
end
