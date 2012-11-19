require 'spec_helper'

describe "PullGithubFeed" do
  context ".perform" do
    it "should initialize a new GithubProcessor" do
      # Hungrlr::GithubProcessor.should_receive(:new).and_return(Hungrlr::GithubProcessor.new)
      Hungrlr::GithubProcessor.any_instance.should_receive(:run).and_return(true)
      PullGithubFeed.perform
    end
  end
end