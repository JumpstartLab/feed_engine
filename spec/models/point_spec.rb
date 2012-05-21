require 'spec_helper'

describe Point do
  let(:user)       { FactoryGirl.create(:user) }
  let(:user_2)    { FactoryGirl.create(:user) }
  let(:image_item) { FactoryGirl.create(:image_item) }

  it "requires both a user and stream item" do
    p = Point.new(user: user)
    z = Point.new(pointable: image_item)
    p.should_not be_valid
    z.should_not be_valid
  end

  it "doesn't let a user point their own post" do
    text_item = FactoryGirl.create(:text_item, user: user)
    p = Point.new(user: user, pointable: text_item)
    p.should_not be_valid
  end

  it "saves with a user and stream item" do
    p = Point.new(user: user, pointable: image_item)
    p.should be_valid
  end

  it "prevents a user from pointing more than one item" do
    p = Point.create(user: user, pointable: image_item)
    p = Point.new(user: user, pointable: image_item)
    p.should_not be_valid
  end
end
