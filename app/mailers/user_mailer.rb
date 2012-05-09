class UserMailer < ActionMailer::Base
  default from: "info@hungrlr.com"

  def welcome_message
    @user = user
    mail(:to => user.email, :subject => "Welcome to Hungrlr!")
  end

end
