require 'minitest_helper'

describe Subscription do
  it "belongs to a user" do
    user = Fabricate(:user)
    sub = user.subscriptions.create
    assert_equal sub.user, user
  end
end