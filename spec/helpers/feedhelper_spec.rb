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
    @item.stub_chain(:event, :actor, :login).and_return("Chris")
    @item.stub_chain(:event, :payload, :commits).and_return("commits")
    @item.stub_chain(:event, :payload, :forkee, :html_url).and_return("http://google.com")
  end

  let(:event_type) { %w(PushEvent ForkEvent random) }

  describe "#github_body" do
    it "processess a Push event" do
      @item.stub_chain(:event, :type).and_return("PushEvent")
      @dummy.github_body(@item)
      @dummy.instance_variable_get(:@github_body).should == "Chris pushed the following commits"
      @dummy.instance_variable_get(:@commits).should == "commits"
    end

    it "processess a Fork event" do
      @item.stub_chain(:event, :type).and_return("ForkEvent")
      @dummy.github_body(@item)
      @dummy.instance_variable_get(:@fork_url).should == "http://google.com"
      @dummy.instance_variable_get(:@github_body).should == "Chris forked"
    end

    it "processes a undefined event" do
      @item.stub_chain(:event, :type).and_return("random")
      @dummy.github_body(@item)
      @dummy.instance_variable_get(:@github_body).should == "Chris performed a random"
      @dummy.instance_variable_get(:@event_type).should == "github_event_unsupported"
    end
  end
end