class ImagePostDecorator < ApplicationDecorator
  decorates :image_post

  def url
    "http://api.feedengine.com/feeds/#{model.user.display_name}"
  end

  def as_json(*params)
    return {} if model.nil?
    
    {
      :type => "ImageItem",
      :image_url => model.image_url,
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :comment => model.comment,
      :created_at => model.created_at,
      :id => model.id,
      :feed => url,
      :link => "#{url}/items/#{model.id}",
      :refeed => false,
      :refeed_link => ""
    }
  end
end