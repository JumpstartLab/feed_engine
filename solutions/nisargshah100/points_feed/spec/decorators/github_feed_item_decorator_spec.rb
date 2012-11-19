require 'spec_helper'

describe GithubFeedItemDecorator do
  it 'returns an empty hash if no model' do
    decorator = GithubFeedItemDecorator.decorate(nil)
    decorator.to_json.should == "{}"
  end
end
