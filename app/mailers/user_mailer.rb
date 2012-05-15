class UserMailer < ActionMailer::Base
  default from: "hungryfeeder@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://feedeng.in/signin"
    mail(to: user.email, subject: "Welcome to HungryFeeder!")
  end
end
