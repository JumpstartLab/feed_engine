# This is where methods to email users are stored
class UserMailer < ActionMailer::Base
  default from: "notifications@superhotfeedengine.com"

  def signup_notification(user_id)
    @user = User.find(user_id)
    @url = "http://superhotfeedengine.com"
    mail(:to => @user.email, :subject => "Super Hot Welcome Email")
  end

  def password_reset(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Super Hot Password Reset")
  end
end
