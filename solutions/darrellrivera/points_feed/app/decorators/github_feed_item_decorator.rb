class GithubFeedItemDecorator < ApplicationDecorator
  decorates :github_feed_item

  def as_json(*params)
    return {} if model.nil?

    {
      :type => "GithubFeedItem",
      :klass => "GithubFeedItem",
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :content => model.content,
      :screen_name => model.screen_name,
      :event_type => model.event_type,
      :repo => model.repo,
      :created_at => model.posted_at,
      :id => model.id,
      :refeed => false,
      :refeed_link => "",
      :reeder => {},
      :awardable => can_award?("GithubFeedItem"),
      :points => model.points
    }
  end
end
