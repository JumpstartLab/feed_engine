# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  post_id    :integer
#  post_type  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Item do
  let(:message) { Fabricate(:message) }
  let(:image) { Fabricate(:image) }
  let(:link) { Fabricate(:link) }

  before(:each) do
    @posts = [message, image, link]
  end

  it "is created when a message is created" do
    expect { Fabricate(:message) }.to change { Item.count }.by(1)
  end

  it "is created when a link is created" do
    expect { Fabricate(:link) }.to change { Item.count }.by(1)
  end

  it "is created when a image is created" do
    expect { Fabricate(:image) }.to change { Item.count }.by(1)
  end

  it "can be queried for it's user" do
    subject.poster.should_not be_nil
  end

  it "can be queried for it's post" do
    @posts.each do |post|
      post.item.post.should == post
    end
  end
end
