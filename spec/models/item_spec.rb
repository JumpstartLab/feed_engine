# == Schema Information
#
# Table name: items
#
#  id                 :integer         not null, primary key
#  poster_id          :integer
#  post_id            :integer
#  post_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  refeed             :boolean
#  original_poster_id :integer
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
    let(:new_message) { Fabricate.build(:message) }
    let(:new_link) { Fabricate.build(:link) }
    let(:new_image) { Fabricate.build(:image) }

    it "message is destroyed" do
      expect { new_message.save }.to change { Item.count }.from(0).to(1)
      expect { new_message.destroy }.to change { Item.count }.from(1).to(0)
    end

    it "link is destroyed" do
      expect { new_link.save }.to change { Item.count }.from(0).to(1)
      expect { new_link.destroy }.to change { Item.count }.from(1).to(0)
    end

    it "image is destroyed" do
      expect { new_image.save }.to change { Item.count }.from(0).to(1)
      expect { new_image.destroy }.to change { Item.count }.from(1).to(0)
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

  it "is refeedable if it hasn't been refed" do
    message.item.refeedable_for?(user).should be true
  end

  it "is not refeedable for the same user that created it" do
    message.item.refeedable_for?(message.item.poster).should_not be true
  end

  it "raises a NotRefeedable error if the user has already refed the item" do
    message.item.refeed_for(user)
    expect { message.item.refeed_for(user) }.to raise_error Item::NotRefeedable
  end

  it "creates another item when refed" do
    expect { message.item.refeed_for(user) }.to change { Item.all.count }.from(0).to(2)
  end

  describe "that is a refeed" do
    it "identifies as a refeed" do
      message.item.refeed_for(user).should be_a_refeed
    end

    it "is no longer refeedable for that user" do
      message.item.refeed_for(user)
      message.item.refeedable_for?(user).should be false
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
