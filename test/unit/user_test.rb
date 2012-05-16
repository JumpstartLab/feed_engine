require 'minitest_helper'

describe User do
  it "creates a User record on create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo@lsqain.in",
    :display_name => "LispyWoo",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.email, "lispy.woo@lsqain.in"
    assert_equal user.display_name, "LispyWoo"
  end
  
  it "sets a user subdomain on create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.2@lsqain.in",
    :display_name => "LispyWoo2",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.subdomain, "lispywoo2"
  end
  
  it "automatically creates a feed for a user after create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.3@lsqain.in",
    :display_name => "LispyWoo3",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.feed.present?, true
  end
  
  it "automatically creates an api key for a user after create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.4@lsqain.in",
    :display_name => "LispyWoo4",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.api_key.blank?, false
  end

  # after_create :send_welcome_email

  it "rejects display names of 'www', 'ftp', and 'api'" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.5@lsqain.in",
    :display_name => "www",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
    ['ftp', 'api'].each do |bad_name|
      user.display_name = bad_name
      user.save
      assert_equal user.valid?, false    
    end
  end
  
  it "rejects displays names that include any characters other than letters, numbers, dashes, or underscores" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.6@lsqain.in",
    :display_name => "LispyWoo6@",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
    user.display_name = "Lispy Woo6"
    user.save
    assert_equal user.valid?, false
  end
  
  it "requires a display name value" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.7@lsqain.in",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
  end
  
  it "requires a unique display name" do
    user_one = Fabricate(:user, :display_name => "SoUnique")
    
    password = "lispy_woo"
    user_two = User.create(:email => "lispy.woo.8@lsqain.in",
    :display_name => "SoUnique",
    :password => password,
    :password_confirmation => password)
    assert_equal user_two.valid?, false
  end
end
