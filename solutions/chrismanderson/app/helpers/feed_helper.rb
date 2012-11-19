module FeedHelper
  def github_body(item)
    login = item.actor_login
    event_type = item.event_type

    if event_type == "PushEvent"
      @commits = item.event_payload_commits
      "#{login} pushed the following commits:"
    elsif event_type == "ForkEvent"
      "Forked #{event_link(item.fork_url, item.fork_url)}".html_safe
    elsif event_type == "CreateEvent"
      ref_type = item.ref_type
      "Created #{ref_type}: #{repo_link(item.repo_name)}".html_safe
    else
     "#{login} performed a #{event_type}"
    end
   end

  def event_link(url, name)
    "<a href=\"#{url}\">#{name}</a>"
  end

  def repo_link(name)
      "<a href=\"http://github.com/#{name}\">#{name}</a>"
  end
end
