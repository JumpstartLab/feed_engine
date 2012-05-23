class ApplicationDecorator < Draper::Base

  def self.per_page
    12
  end

  def refeeder
    return {} unless model.original_post
    {
      :avatar => model.original_post.user.avatar,
      :display_name => model.original_post.user.display_name
    }
  end

  def current_user=(user)
    @current_user = user
  end

  def can_refeed?
    return (not @current_user.already_refeeded?(model)) if @current_user
    false
  end

  def can_award?(type)
    return @current_user.can_award?(model, type) if @current_user
    true
  end

  def refeed_url(post)
    feed = model.user.display_name
    "http://api.pointsfeed.in/feeds/#{feed}/items/#{post.id}.json" if post
  end

  def feed_url
    "http://api.pointsfeed.in/feeds/#{model.user.display_name}"
  end

end