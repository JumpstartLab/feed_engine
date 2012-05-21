# == Schema Information
#
# Table name: github_posts
#
#  id           :integer         not null, primary key
#  github_id    :integer
#  published_at :datetime
#  repo_name    :string(255)
#  repo_url     :string(255)
#  github_type  :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class GithubPost < ActiveRecord::Base
  attr_accessible :published_at, :repo_name, :repo_url, :github_type, :github_id, :created_at

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post

  validates_uniqueness_of :github_id
end
