class UserMailer < ActionMailer::Base
  default from: "allthepoints@pointsfeed.in"

  def welcome_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to PointsFeed!")
  end
end
