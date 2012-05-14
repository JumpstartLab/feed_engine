class UserMailer < ActionMailer::Base
  default from: "info@hungrlr.com"
 include Resque::Mailer

  def welcome_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Hungrlr!")
  end

end
