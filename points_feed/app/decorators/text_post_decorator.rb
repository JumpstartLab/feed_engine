class TextPostDecorator < ApplicationDecorator
  decorates :text_post

  def as_json(*params)
    {
      :type => "TextItem",
      :text => model.content,
      :created_at => model.created_at,
      :id => model.id,
      :feed => "http://api.feedengine.com/feeds/#{model.user.display_name}",
      :link => "http://api.feedengine.com/feeds/#{model.user.display_name}/items/#{model.id}",
      :refeed => false,
      :refeed_link => ""
    }
  end
end