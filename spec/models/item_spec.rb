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

  describe "is created when a" do
    it "message is created" do
      expect { Fabricate(:message) }.to change { Item.count }.from(0).to(1)
    end

    it "link is created" do
      expect { Fabricate(:link) }.to change { Item.count }.from(0).to(1)
    end

    it "image is created" do
      expect { Fabricate(:image) }.to change { Item.count }.from(0).to(1)
    end
  end

  describe "is destroyed when a" do
    before(:all) do
      message = Fabricate.build(:message)
      link = Fabricate.build(:link)
      image = Fabricate.build(:image)
    end

    it "message is destroyed" do
      expect { message.save }.to change { Item.count }.from(0).to(1)
      expect { message.destroy }.to change { Item.count }.from(1).to(0)
    end

    it "link is destroyed" do
      expect { link.save }.to change { Item.count }.from(0).to(1)
      expect { link.destroy }.to change { Item.count }.from(1).to(0)
    end

    it "image is destroyed" do
      expect { image.save }.to change { Item.count }.from(0).to(1)
      expect { image.destroy }.to change { Item.count }.from(1).to(0)
    end
  end

  it "can be queried for it's user" do
    subject.poster.should_not be_nil
  end

  it "can be queried for it's post" do
    message.item.post.should == message
    image.item.post.should == image
    link.item.post.should == link
  end
end
