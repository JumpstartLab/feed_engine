class UserMailer < ActionMailer::Base
  default from: "hungryfeeder@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://feedeng.in/"
    mail(to: user.email, subject: "Welcome to HungryFeeder!")
  end

  def reset_password_email(user)
    @user = user
    @new_password = Digest::SHA512.hexdigest(
      Digest::SHA384.hexdigest(
        Digest::SHA256.hexdigest(
      "#{@user.email}HuNgRyF33d#{FeedEngine::Application.config.secret_token}"
        )))
    mail(to: user.email, subject: "Password Reset!")
  end
end
