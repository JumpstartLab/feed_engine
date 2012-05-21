class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token, :secret, :login

  belongs_to :user

  validate :connected?
  after_create :initial_gathering


  def self.find_or_create_by_auth( auth )
    user = User.find_or_create_by_uid( auth['uid'] )

    user.name       = auth['info']['name']
    user.twitter    = auth['info']['nickname']
    user.github     = auth['info']['nickname']
    user.url        = auth['info']['urls']['Website']
    user.bio        = auth['info']['description']
    user.avatar_url = auth['info']['image']

    user.save!

    return user
  end

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
