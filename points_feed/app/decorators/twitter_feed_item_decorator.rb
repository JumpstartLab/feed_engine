class TwitterFeedItemDecorator < ApplicationDecorator
  decorates :twitter_feed_item

  def as_json(*params)
    return {} if model.nil?
    
    {
      :type => "TwitterFeedItem",
      :klass => "TwitterFeedItem",
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :content => model.content,
      :screen_name => model.screen_name,
      :created_at => model.posted_at,
      :id => model.id,
      :refeed => false,
      :refeed_link => "",
      :reeder => {},
      :points => model.points
    }
  end
end
