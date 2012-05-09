class UserMailer < ActionMailer::Base
  default from: "hungryfeeder@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/signin"
    mail(to: user.email, subject: "WELCOME TO REST OF YOUR LIFE")
  end
end
