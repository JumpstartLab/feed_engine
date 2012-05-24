require 'spec_helper'

describe InstagramFeedItemDecorator do
  it 'returns an empty hash if no model' do
    decorator = InstagramFeedItemDecorator.decorate(nil)
    decorator.to_json.should == "{}"
  end
end
