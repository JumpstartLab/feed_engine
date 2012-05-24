class Githubevent < ActiveRecord::Base
  include PostsHelper
  VALID_TYPES= ["CreateEvent", "ForkEvent","PushEvent"]
  attr_accessible :content, :action, :event_id, :handle, :post_time, :repo
  has_many :points, :through => :posts
  has_many :posts, :as => :postable

  def self.import_posts(user_id)
    user = User.find(user_id)
    github = Github.new
    events = github.events.performed(user.github_handle)
    existing_events = user.githubevents
    sign_up_time = user.authentications.find_by_provider('github').created_at
    events.reverse.each do |event|
      if VALID_TYPES.include?(event.type)
        unless existing_events.find_by_event_id(event.id) || Time.zone.parse(event.created_at) < sign_up_time
          new_event = existing_events.create(action: event.type,
          event_id: event.id,
          handle: event.actor.login,
          post_time: event.created_at,
          repo: event.repo.name,
          content: create_content(event.actor.login, event.type, event.repo.name))
          
          new_event.link_to_poly_post(new_event, user.feed)
        end
      end
    end
  end

  def self.create_content(event_handle, event_action, event_repo)
    action_text = case event_action
     when "CreateEvent" then "created a new repo"
     when "ForkEvent" then "created a new fork"
     when "PushEvent" then "pushed to repo"
    end

    "#{event_handle} #{action_text} #{event_repo.split("/").last}"
  end
end
