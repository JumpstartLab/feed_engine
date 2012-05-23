require 'spec_helper'
require 'time'

describe PointsfeedImporter do
  let!(:user) { Fabricate(:user) }
  let!(:user2) { Fabricate(:user, :email => 'two@two.com', :display_name => 'two') }

  before(:each) do
    user2.friends << user
    friendship = Friendship.all.first
    friendship.update_attributes(:status => Friendship::ACTIVE)
  end

  context 'refeeds' do
    let!(:text_post) { Fabricate(:text_post, :user => user, :created_at => Time.now + 1000) }

    before(:each) do
      PointsfeedImporter.perform
    end

    it 'with a valid number of posts' do
      user2.stream(10).length.should == 1
    end

    it 'with a valid post' do
      user2.stream(10).first.original_post.should == text_post
    end
  end

  context 'doesnt refeed' do
    let!(:text_post) { Fabricate(:text_post, :user => user, :created_at => Time.now - 1000) }

    before(:each) do
      PointsfeedImporter.perform
    end

    it 'when created_at date is in the past' do
      user2.stream(10).length.should == 0
    end
  end

end