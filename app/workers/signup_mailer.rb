# Mailer for signing up
class SignupMailer
  @queue = :mailer

  def self.perform(user_id)
    @user = User.find(user_id)
    UserMailer.signup_notification(@user.id).deliver
  end
end
