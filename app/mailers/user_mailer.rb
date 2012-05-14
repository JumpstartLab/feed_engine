class UserMailer < ActionMailer::Base
  default from: "tkiefhab@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Get your feed on!")
  end
end
