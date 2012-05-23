require 'spec_helper'

describe FeedHelper do
  class DummyClass
  end

  before(:all) do
    @dummy = DummyClass.new
    @dummy.extend FeedHelper
  end

  before(:each) do
    @item = double("item")
    @item.stub_chain(:actor_login).and_return("Chris")
    @item.stub_chain(:event_payload_commits).and_return("commits")
    @item.stub_chain(:repo_name).and_return("commits")
    @item.stub_chain(:ref_type).and_return("commits")
    @item.stub_chain(:fork_url).and_return("http://google.com")
  end

  let(:event_type) { %w(PushEvent ForkEvent random) }

  describe "#github_body" do
    it "processess a Push event" do
      @item.stub_chain(:event_type).and_return("PushEvent")
      @dummy.github_body(@item).should == "Chris pushed the following commits:"
      @dummy.instance_variable_get(:@commits).should == "commits"
    end

    it "processess a Fork event" do
      @item.stub_chain(:event_type).and_return("ForkEvent")
      @dummy.github_body(@item).should include "Forked"
    end

    it "processess a created event" do
      @item.stub_chain(:event_type).and_return("CreateEvent")
      @dummy.github_body(@item).should include "Created"
    end

    it "processes a undefined event" do
      @item.stub_chain(:event_type).and_return("random")
      @dummy.github_body(@item).should include "performed"
    end
  end
end
