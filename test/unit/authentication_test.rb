require 'minitest_helper'

describe Authentication do
  it "can create a record with provider name and uid" do
    user = Fabricate(:user)
    auth = user.authentications.create(:provider => "twitter", :uid => "123456")
    assert_equal auth.valid?, true
    assert_equal auth.user_id, user.id
    assert_equal auth.provider, "twitter"
    assert_equal auth.uid, "123456"
  end
end
