module FeedHelper
  def github_body(item)
    event = item.event
    login = event.actor.login
    @event_type = event.type
    @commits = []

    if @event_type == "PushEvent"
      @github_body = "#{login} pushed the following commits"
      @commits = event.payload.commits
    elsif @event_type == "ForkEvent"
      @fork_url = event.payload.forkee.html_url 
      @github_body = "#{login} forked"
    else
     @github_body = "#{login} performed a #{@event_type}"
     @event_type =  "github_event_unsupported"
    end
   end
end
