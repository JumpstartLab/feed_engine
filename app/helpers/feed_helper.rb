module FeedHelper
  def github_body(item) 
    event = item.event
    login = event.actor.login
    event_type = event.type

    if event_type == "PushEvent"
      @commits = event.payload.commits
      "#{login} pushed the following commits:"
    elsif event_type == "ForkEvent"
      fork_url = event.payload.forkee.html_url 
      "Forked #{full_url(fork_url, fork_url)}".html_safe
    elsif event_type == "CreateEvent"
      ref_type = event.payload.ref_type 
      "Created #{ref_type}: #{repo_url(event.repo.name)}".html_safe
    else
     "#{login} performed a #{event_type}"
    end
   end

  def full_url(url, name)
    "<a href=\"#{url}\">#{name}</a>"
  end

  def repo_url(name)
      "<a href=\"http://github.com/#{name}\">#{name}</a>"
  end
end
