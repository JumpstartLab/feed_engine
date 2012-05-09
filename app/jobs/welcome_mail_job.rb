class WelcomeMailJob
  @queue = :emails

  def self.perform(user)
    user = User.find(user)
    UserMailer.welcome_email(user).deliver
  end
end