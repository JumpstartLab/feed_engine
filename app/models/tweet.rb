# == Schema Information
#
# Table name: tweets
#
#  id              :integer         not null, primary key
#  subscription_id :integer
#  body            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  poster_id       :integer
#

class Tweet < ActiveRecord::Base
  include Postable
  attr_accessible :body, :subscription_id, :created_at

  belongs_to :subscription

  def subscription
    Subscription.find(subscription_id)
  end

end
