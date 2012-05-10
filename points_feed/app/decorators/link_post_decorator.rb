class LinkPostDecorator < ApplicationDecorator
  decorates :link_post

  def as_json(*params)
    {
      :type => "LinkItem",
      :link_url => model.content,
      :comment => model.comment,
      :created_at => model.created_at,
      :id => model.id,
      :feed => "http://api.feedengine.com/feeds/#{model.user.display_name}",
      :link => "http://api.feedengine.com/feeds/#{model.user.display_name}/items/#{model.id}",
      :refeed => false,
      :refeed_link => ""
    }
  end
end