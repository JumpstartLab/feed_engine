class Githubevent < ActiveRecord::Base
  include PostsHelper
  VALID_TYPES= ["CreateEvent", "ForkEvent","PushEvent"]
  attr_accessible :content, :action, :event_id, :handle, :event_time, :repo
  has_one :post, :as => :postable

  def self.import_posts(user_id)
    user = User.find(user_id)
    github = Github.new
    events = github.events.performed(user.github_handle)
    existing_events = user.githubevents

    events.reverse.each do |event|
      if VALID_TYPES.include?(event.type)
      # user.githubevents.find_or_create_by_event_id(action: event.type,
      #   event_id: event.id,
      #   handle: event.actor.login,
      #   event_time: event.created_at,
      #   repo: event.repo.name,
      #   content: create_content(event.actor.login, event.type, event.repo.name))
      # end
        unless existing_events.find_by_event_id(event.id)
          new_event = existing_events.create(action: event.type,
          event_id: event.id,
          handle: event.actor.login,
          event_time: event.created_at,
          repo: event.repo.name,
          content: create_content(event.actor.login, event.type, event.repo.name))
          link_to_poly_post(new_event)
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
