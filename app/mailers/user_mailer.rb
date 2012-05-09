class UserMailer < ActionMailer::Base
  default from: "foo@fooffy.com"

  def welcome_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Hungrlr!")
  end
end