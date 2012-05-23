require 'spec_helper'

describe TwitterFeedItemDecorator do
  it 'returns an empty hash if no model' do
    decorator = TwitterFeedItemDecorator.decorate(nil)
    decorator.to_json.should == "{}"
  end
end
