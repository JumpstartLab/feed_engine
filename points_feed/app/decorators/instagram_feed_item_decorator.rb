class InstagramFeedItemDecorator < ApplicationDecorator
  decorates :instagram_feed_item

  def as_json(*params)
    return {} if model.nil?

    {
      :type => "InstagramFeedItem",
      :klass => "InstagramFeedItem",
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :image_url => model.image_url,
      :comment => model.comment,
      :created_at => model.posted_at,
      :id => model.id,
      :refeed => false,
      :refeed_link => "",
      :reeder => {},
      :points => model.points
    }
  end
end
