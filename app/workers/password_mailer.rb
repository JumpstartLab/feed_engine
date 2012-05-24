# Mailer for reset password email
class PasswordMailer
  @queue = :mailer

  def self.perform(user_id)
    @user = User.find(user_id)
    UserMailer.password_reset(@user.id).deliver
  end
end
