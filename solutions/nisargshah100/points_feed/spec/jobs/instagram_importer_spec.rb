require 'spec_helper'
require 'time'

describe InstagramImporter do
  let!(:user) { Fabricate(:user) }
  let!(:authentications) { [user.authentications.create(:uid => "nisargshah100", :provider => "instagram")] }
  
  context 'imports events' do
    it 'which are after authentication' do
      InstagramImporter.stub(:import_instagram) { user.instagram_feed_items.create(:posted_at => Time.now + 1000) }
      InstagramImporter.perform
      user.instagram_feed_items.length.should == 1
    end
  end

  context 'doesnt import events' do
    it 'that are before the authentication date' do
      InstagramImporter.stub(:import_instagram) { user.instagram_feed_items.create(:posted_at => Time.now - 1000) }
      InstagramImporter.perform
      user.reload.instagram_feed_items.length.should == 0
    end
  end
end