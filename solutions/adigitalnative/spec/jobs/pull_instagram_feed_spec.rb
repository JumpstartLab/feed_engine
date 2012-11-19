require 'spec_helper'

describe "PullInstagramFeed" do
  context ".perform" do
    it "should initialize a new InstagramProcessor" do
      # Hungrlr::GithubProcessor.should_receive(:new).and_return(Hungrlr::GithubProcessor.new)
      Hungrlr::InstagramProcessor.any_instance.should_receive(:run).and_return(true)
      PullInstagramFeed.perform
    end
  end
end