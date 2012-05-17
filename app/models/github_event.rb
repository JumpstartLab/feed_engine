class GithubEvent < ActiveRecord::Base
  include Postable
  include Service
  attr_accessible :repo, :event_type

end
