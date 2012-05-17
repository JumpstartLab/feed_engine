class Authentication < ActiveRecord::Base
  attr_accessible :user, :token, :secret, :provider
  belongs_to :user
  has_one :twitter_account
  has_one :github_account

  def self.twitter
    where(provider: "twitter").first
  end

  def self.twitter?
    where(provider: "twitter").size > 0 ? true : false
  end

  def self.github
    where(provider: "github").first
  end

  def self.github?
    where(provider: "github").size > 0 ? true : false
  end

end
