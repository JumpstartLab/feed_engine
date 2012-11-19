require 'spec_helper'
require 'time'

describe TwitterImporter do
  let!(:user) { Fabricate(:user) }
  let!(:authentications) { [user.authentications.create(:uid => "nisargshah100", :provider => "twitter")] }

  context 'imports events' do
    it 'which are after authentication' do
      TwitterImporter.stub(:import_tweets) { user.twitter_feed_items.create(:posted_at => Time.now + 1000) }
      TwitterImporter.perform
      user.twitter_feed_items.length.should == 1
    end
  end

  context 'doesnt import events' do
    it 'that are before the authentication date' do
      TwitterImporter.stub(:import_tweets) { user.twitter_feed_items.create(:posted_at => Time.now - 1000) }
      TwitterImporter.perform
      user.reload.twitter_feed_items.length.should == 0
    end
  end
end