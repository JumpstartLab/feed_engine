class UserMailer < ActionMailer::Base
  default from: "horace.badger@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => @user.email,
      :subject => "Thanks for Signing Up!")
  end
end