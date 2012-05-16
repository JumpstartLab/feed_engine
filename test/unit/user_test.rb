require 'minitest_helper'

describe User do
  it "creates a User record on create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.wahoo@lsqain.in",
    :display_name => "LispyWahoo",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.email, "lispy.wahoo@lsqain.in"
    assert_equal user.display_name, "LispyWahoo"
  end
  
  it "sets a user subdomain on create" do
    password = "lispy_woo"
    user = User.create(:email => "lispy.wahoo@lsqain.in",
    :display_name => "LispyWahoo",
    :password => password,
    :password_confirmation => password)
    assert_equal user.valid?, true
    assert_equal user.subdomain, "lispywahoo"
  end
  
  # before_create :set_user_subdomain
  # after_create :set_user_feed
  # after_create :generate_api_key
  # after_create :send_welcome_email
  # devise :database_authenticatable, :recoverable, :validatable
  # attr_accessible :email, :password, :password_confirmation, :display_name, :subdomain
  # has_many :authentications
  # has_many :tweets
  # has_one :feed
  # 
  # 
  # DISPLAY_NAME_REGEX = /^[\w-]*$/
  # validates :display_name, 
  #   format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, dashes, or underscores" },
  #   presence: true, 
  #   uniqueness: true,
  #   exclusion: { in: %w(www ftp api), message: "can not be www, ftp, or api" }

end
