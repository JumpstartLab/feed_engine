require 'spec_helper'

describe Item, :focus => true do
  it "is created when a message is created" do
    expect { Fabricate(:message) }.to change { Item.count }.by(1)
  end

  it "is created when a link is created" do
    expect { Fabricate(:link) }.to change { Item.count }.by(1)
  end

  it "is created when a image is created" do
    expect { Fabricate(:image) }.to change { Item.count }.by(1)
  end
end
