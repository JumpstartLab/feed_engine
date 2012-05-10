# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  display_name    :string(255)
#

# Users of the site
class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :display_name
  validates :email, :uniqueness => true
  validates_presence_of :email, :message => "is required."
  validates :password, :length => { :minimum => 6 }, :allow_blank => true
  validates_format_of :email,
                      :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
                      :allow_blank => true
  validates :display_name, :presence => true,
                           :format => { :with => /^[a-zA-Z\d\-_]*$/,
    :message => "must be only letters, numbers, dashes, or underscores"
                           }

  def send_welcome_email
    UserMailer.signup_notification(self).deliver
  end

end
