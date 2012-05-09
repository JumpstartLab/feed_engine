class UserMailer < ActionMailer::Base
  default from: "notifications@feedengine.heroku.com"

  def signup_notification(user)
    @user = user
    @url = "http://feedengine.heroku.com"
    mail(:to => @user.email, :subject => "Welcome to Feed Engine")
  end
end
