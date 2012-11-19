require 'spec_helper'

describe "PullTwitterFeed" do
  context ".perform" do
    it "should initialize a new TwitterProcessor" do
      # Hungrlr::GithubProcessor.should_receive(:new).and_return(Hungrlr::GithubProcessor.new)
      Hungrlr::TweetProcessor.any_instance.should_receive(:run).and_return(true)
      PullTwitterFeed.perform
    end
  end
end