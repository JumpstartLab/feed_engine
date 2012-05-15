class GithubFeedItemDecorator < ApplicationDecorator
  decorates :github_feed_item

  def as_json(*params)
    return {} if model.nil?
    
    {
      :type => "GithubFeedItem",
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :content => model.content,
      :created_at => model.posted_at,
      :id => model.id,
      :refeed => false,
      :refeed_link => ""
    }
  end
end
