class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token, :secret, :login

  belongs_to :user

  validate :connected?
  after_create :initial_gathering

  private

  def initial_gathering
    Resque.enqueue("#{provider.capitalize}Job".constantize, user, self)
  end 

  def connected?
    if Authentication.where("user_id = ? and provider = ?", user_id, provider).any?
      errors[:base] = "#{provider.capitalize} is already linked."
    end
  end
end
