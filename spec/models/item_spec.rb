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
  let(:user)    { Fabricate(:user) }
  let(:message) { Fabricate(:message) }
  let(:image)   { Fabricate(:image) }
  let(:link)    { Fabricate(:link) }

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
    message.item.poster.id.should == message.poster_id
  end

  it "can be queried for it's post" do
    message.item.post.should == message
    image.item.post.should == image
    link.item.post.should == link
  end

  it "creates another item when refed" do
    expect { message.item.refeed_for(user) }.to change { Item.all.count }.from(0).to(2)
  end

  it "raises an argument error if refed by the same user that created it" do
    expect { message.item.refeed_for(message.item.poster) }.to raise_error ArgumentError
  end

  describe "that is a refeed" do
    it "identifies as a refeed" do
      message.item.refeed_for(user).should be_a_refeed
    end

    describe "is destroyed when the associated post is destroyed" do
      let(:refeeder) { Fabricate(:user) }
      let(:message) { Fabricate.build(:message) }

      it "message is destroyed" do
        expect { message.save }.to change { Item.count }.from(0).to(1)
        expect { message.item.refeed_for(refeeder) }.to change { Item.count }.from(1).to(2)
        expect { message.destroy }.to change { Item.count }.from(2).to(0)
      end
    end
  end
end
