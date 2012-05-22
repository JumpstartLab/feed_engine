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
  
  # it "automatically creates an api key for a user after create" do
  #   password = "lispy_woo"
  #   user = User.create(:email => "lispy.woo.4@lsqain.in",
  #   :display_name => "LispyWoo4",
  #   :password => password,
  #   :password_confirmation => password)
  #   assert_equal user.valid?, true
  #   assert_equal user.api_key.blank?, false
  # end

  # after_create :send_welcome_email

  it "rejects display names of 'www', 'ftp', 'api', and 'null'" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.5@lsqain.in",
    :display_name => "www",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
    ['ftp', 'FTP', 'api', 'API', 'null', 'NULL'].each do |bad_name|
      user.display_name = bad_name
      user.save
      assert_equal user.valid?, false    
    end
  end
  
  it "rejects displays names that include any characters other than letters, numbers, or dashes" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.6@lsqain.in",
    :display_name => "LispyWoo6@",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
    ["Lispy Woo6","Lispy_Woo6"].each do |name|
      user.display_name = name
      user.save
      assert_equal user.valid?, false
    end
  end
  
  it "rejects displays names that start with a dash" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.woo.6@lsqain.in",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, false
    ["-LispyWoo2010","----"].each do |name|
      user.display_name = name
      user.save
      assert_equal user.valid?, false
    end
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
    user_two.display_name = "sounique"
    user_two.save
    assert_equal user_two.valid?, false
  end
  
  describe ".subscribe" do
    it "subscribes a user to a given feed" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      user1.subscribe(user2.feed.name)
      assert_equal user1.subscriptions.first.feed_id, user2.feed.id
    end
    
    it "does not allow a user to subscribe to their own feed" do
      user = Fabricate(:user)
      user.subscribe(user.feed.name)
      assert_equal [], user.subscriptions
    end

    it "does not allow a user to subscribe to same feed twice" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      2.times { user1.subscribe(user2.feed.name) }
      assert_equal 1, user1.subscriptions.count
    end
  end
end
