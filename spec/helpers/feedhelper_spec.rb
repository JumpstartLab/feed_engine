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
    @item.stub_chain(:event, :repo, :name).and_return("commits")
    @item.stub_chain(:event, :payload, :ref_type).and_return("commits")
    @item.stub_chain(:event, :payload, :forkee, :html_url).and_return("http://google.com")
  end

  let(:event_type) { %w(PushEvent ForkEvent random) }

  describe "#github_body" do
    it "processess a Push event" do
      @item.stub_chain(:event, :type).and_return("PushEvent")
      @dummy.github_body(@item).should == "Chris pushed the following commits:"
      @dummy.instance_variable_get(:@commits).should == "commits"
    end

    it "processess a Fork event" do
      @item.stub_chain(:event, :type).and_return("ForkEvent")
      @dummy.github_body(@item).should include "Forked"
    end

    it "processess a created event" do
      @item.stub_chain(:event, :type).and_return("CreateEvent")
      @dummy.github_body(@item).should include "Created"
    end

    it "processes a undefined event" do
      @item.stub_chain(:event, :type).and_return("random")
      @dummy.github_body(@item).should include "performed"
    end
  end
end