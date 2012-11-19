class GithubAccount < ActiveRecord::Base
  attr_accessible :authentication, :uid, :nickname, :last_status_id, :image
  belongs_to :authentication

  delegate :user, :to => :authentication
  delegate :id, :to => :user, :prefix => true

  def update_last_status_id_if_necessary(new_status_id)
    if DateTime.parse(last_status_id) < DateTime.parse(new_status_id)
      update_attribute("last_status_id", new_status_id)
    end
  end
end

# == Schema Information
#
# Table name: github_accounts
#
#  id                :integer         not null, primary key
#  authentication_id :integer
#  uid               :integer
#  nickname          :string(255)
#  last_status_id    :string(255)     default("0"), not null
#  string            :string(255)     default("0"), not null
#  image             :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

