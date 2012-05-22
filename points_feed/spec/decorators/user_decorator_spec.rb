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
end
