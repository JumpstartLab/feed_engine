require 'spec_helper'
require 'time'

describe GithubImporter do
  let!(:user) { Fabricate(:user) }
  let!(:authentications) { [user.authentications.create(:uid => "nisargshah100", :provider => "github")] }
  
  context 'imports events' do
    it 'which are after authentication' do
      GithubImporter.stub(:import_events) { user.github_feed_items.create(:posted_at => Time.now + 1000) }
      GithubImporter.perform
      user.github_feed_items.length.should == 1
    end
  end

  context 'doesnt import events' do
    it 'that are before the authentication date' do
      GithubImporter.stub(:import_events) { user.github_feed_items.create(:posted_at => Time.now - 1000) }
      GithubImporter.perform
      user.reload.github_feed_items.length.should == 0
    end
  end
end
