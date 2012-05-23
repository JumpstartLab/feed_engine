class GithubItem < ActiveRecord::Base
  include Streamable
  attr_accessible :event, :event_id

  validates_presence_of :event_id


  belongs_to :user

  has_many :stream_items, :as => :streamable

  serialize :event

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id, event_id: parsed_json["event"]["id"], event: parsed_json["event"])
  end

  def event_type
    event["type"]
  end

  def actor_login
    event["actor"]["login"]
  end

  def event_payload
    event["payload"]
  end

  def event_payload_commits
    event["payload"]["commits"]
  end

  def fork_url
    event["payload"]["forkee"]["html_url"]
  end

  def ref_type
    event["payload"]["ref_type"]
  end

  def repo_name
    event["repo"]["name"]
  end

end
