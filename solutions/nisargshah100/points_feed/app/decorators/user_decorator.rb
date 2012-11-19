class UserDecorator < ApplicationDecorator
  decorates :user

  def url
    "http://api.pointsfeed.in/feeds/#{model.display_name}"
  end

  def pages
    model.posts.count / ApplicationDecorator.per_page + 1
  end

  def most_recent_text_item
    model.text_posts.first
  end

  def most_recent_image_item
    model.image_posts.first
  end

  def most_recent_link_item
    model.link_posts.first
  end

  def as_json(*params)
    return {} if model.nil?

    {
      :name => model.display_name,
      :avatar => model.avatar,
      :id => model.id,
      :private => model.private,
      :link => "#{url}.json",
      :items => {
        :pages => pages,
        :first_page => "#{url}/items.json?page=1",
        :last_page => "#{url}/items.json?page=#{pages}",
        :most_recent => [
          TextPostDecorator.decorate(most_recent_text_item),
          ImagePostDecorator.decorate(most_recent_image_item),
          LinkPostDecorator.decorate(most_recent_link_item)
        ]
      }
    }
  end
end