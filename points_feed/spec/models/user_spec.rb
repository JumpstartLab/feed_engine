require 'spec_helper'


describe User do
  context "relation_for" do
    it "parses a string and returns a matching AREL object" do
      user = Fabricate(:user)
      user.text_posts.create(content: "Content Sample")
      user.relation_for("text_posts").count.should == 1
    end

    it "returns TextPost if it fails to parse the input string" do
      user = Fabricate(:user)
      user.text_posts.create(content: "Content Sample")
      user.relation_for("foo bar baz quux").count.should == 1
    end
  end
end