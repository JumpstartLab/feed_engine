require 'spec_helper'
require 'date'

describe UserDecorator do
  before { ApplicationController.new.set_current_view_context }

  describe "most_recent_text_item" do
    let!(:user) { Fabricate(:user, :id => 1 ) }
    let!(:text_post_1) { Fabricate(:text_post, :user => user, :created_at => Time.now - 500) }
    let!(:text_post_2) { Fabricate(:text_post, :user => user, :created_at => Time.now - 1000) }
    let!(:link_post) { Fabricate(:link_post, :user => user, :created_at => Time.now) }

    it "returns the most recent text item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_text_item.should == text_post_1
    end

    it "returns a text item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_text_item.class.should == TextPost
    end

  end

  describe "most_recent_image_item" do
    let!(:user) { Fabricate(:user, :id => 1 ) }
    let!(:image_post_1) { Fabricate(:image_post, :user => user, :created_at => Time.now - 500) }
    let!(:image_post_2) { Fabricate(:image_post, :user => user, :created_at => Time.now - 1000) }
    let!(:link_post) { Fabricate(:link_post, :user => user, :created_at => Time.now) }

    it "returns the most recent image item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_image_item.should == image_post_1
    end

    it "returns an image item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_image_item.class.should == ImagePost
    end

  end

  describe "most_recent_link_item" do
    let!(:user) { Fabricate(:user, :id => 1 ) }
    let!(:link_post_1) { Fabricate(:link_post, :user => user, :created_at => Time.now - 500) }
    let!(:link_post_2) { Fabricate(:link_post, :user => user, :created_at => Time.now - 1000) }
    let!(:text_post) { Fabricate(:text_post, :user => user, :created_at => Time.now) }

    it "returns the most recent link item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_link_item.should == link_post_1
    end

    it "returns a link item" do
      decorated_user = UserDecorator.decorate(user)
      decorated_user.most_recent_link_item.class.should == LinkPost
    end

  end

  describe "as_json" do
    let!(:user) { Fabricate(:user, :id => 1 ) }

    it "returns valid JSON data" do
      decorated_user = UserDecorator.decorate(user)
      user.id.should == decorated_user.as_json[:id]
    end
  end
end
