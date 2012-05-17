# This is where methods to email users are stored
class UserMailer < ActionMailer::Base
  default from: "notifications@feedengine.heroku.com"

  def signup_notification(user)
    @user = user
    @url = "http://superhotfeedengine.com"
    mail(:to => @user.email, :subject => "Welcome to Feed Engine")
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Super Hot Password Reset"
  end
end
