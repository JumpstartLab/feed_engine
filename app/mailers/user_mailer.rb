class UserMailer < ActionMailer::Base
  default from: "info@hungrlr.com"
  include Resque::Mailer

  def welcome_message(email)
    mail(:to => email, :subject => "Welcome to Hungrlr!")
  end

end
