class LinkPostDecorator < ApplicationDecorator
  decorates :link_post

  def url
    "http://api.pointsfeed.in/feeds/#{model.user.display_name}"
  end

  def as_json(*params)
    return {} if model.nil?
    
    {
      :type => "LinkItem",
      :link_url => model.content,
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