require 'spec_helper'

describe GithubItem do
  let!(:event) { JSON.parse'{"type":"Commit",
                             "actor":{"login":"worace"},
                             "payload":{"ref_type":"branch","commits":"hello","forkee":{"html_url":"google.com"}},
                             "repo":{"name":"sweet_repo"}}' }
  let(:item) { GithubItem.new }
  before { item.event = event }

  context "#event_type" do
    it "returns the contents" do
      item.event_type.should == "Commit"
    end
  end

  context "#actor_login" do
    it "returns the contents" do
      item.actor_login.should == "worace"
    end
  end

  context "#event_payload" do
    it "returns the contents" do
      item.event_payload.should == {"ref_type"=>"branch","commits"=>"hello","forkee"=>{"html_url"=>"google.com"}}
    end
  end

  context "#event_payload_commits" do
    it "returns the contents" do
      item.event_payload_commits.should == "hello"
    end
  end

  context "#fork_url" do
    it "returns the contents" do
      item.fork_url.should == "google.com"
    end
  end

  context "#ref_type" do
    it "returns the contents" do
      item.ref_type.should == "branch"
    end
  end

  context "#repo_name" do
    it "returns the contents" do
      item.repo_name.should == "sweet_repo"
    end
  end

end
