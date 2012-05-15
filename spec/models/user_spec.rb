# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  display_name    :string(255)
#

require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  it "can be queried for it's items" do
    Fabricate(:message, :poster_id => user.id)
    Fabricate(:image, :poster_id => user.id)
    Fabricate(:link, :poster_id => user.id)

    user.items.should_not be_empty
  end

  it "does not return items that belong to other users" do
    Fabricate(:message, :poster_id => user.id)
    Fabricate(:image, :poster_id => user.id)
    Fabricate(:link, :poster_id => user.id)

    user2 = Fabricate(:user)
    user2_items = [
      Fabricate(:message, :poster_id => user2.id),
      Fabricate(:image, :poster_id => user2.id),
      Fabricate(:link, :poster_id => user2.id)
    ]

    user2.items.each do |item|
      user.items.should_not include item
    end
  end
end
