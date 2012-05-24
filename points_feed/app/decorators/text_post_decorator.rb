class TextPostDecorator < ApplicationDecorator
  decorates :text_post

  def as_json(*params)
    return {} if model.nil?

    {
      :type => "TextItem",
      :klass => "Post",
      :text => model.content,
      :feeder => {
        :avatar => model.user.avatar,
        :name => model.user.display_name
      },
      :created_at => (model.original_post || model).created_at,
      :id => model.id,
      :feed => "#{feed_url}.json",
      :link => "#{feed_url}/items/#{model.id}.json",
      :refeed => model.original_post != model,
      :refeed_link => "#{refeed_url(model.original_post)}",
      :refeeder => refeeder,
      :can_refeed => can_refeed?,
      :awardable => can_award?("Post"),
      :points => model.points
    }
  end
end