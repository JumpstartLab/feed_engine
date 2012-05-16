class GithubItem < ActiveRecord::Base
  attr_accessible :gist

  belongs_to :user 

  has_many :stream_items, :as => :streamable

  serialize :activity
end
