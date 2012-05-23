class ImagePostDecorator < ApplicationDecorator
  decorates :image_post

  def as_json(*params)
    return {} if model.nil?

    {
      :type => "ImageItem",
      :image_url => model.image_url,
      :klass => "Post",
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :comment => model.comment,
      :created_at => (model.original_post || model).created_at,
      :id => model.id,
      :feed => "#{feed_url}.json",
      :link => "#{feed_url}/items/#{model.id}.json",
      :refeed => model.original_post != model,
      :refeed_link => "#{refeed_url(model.original_post)}",
      :refeeder => refeeder,
      :can_refeed => can_refeed?,
      :points => model.points
    }
  end
end