class Instagramimage < ActiveRecord::Base
  include PostsHelper
  has_one :post, :as => :postable
  attr_accessible :content, :handle, :source_id, :post_time, :caption, :user_id

  def self.import_posts(user_id)
    user = User.find(user_id)
    call = "/v1/users/#{user.instagram_id}/media/recent/?access_token=#{user.instagram_token}"
    sign_up_time = user.authentications.find_by_provider('instagram').created_at
    response = Instagramimage.faraday_connection.get call
    mash = Hashie::Mash.new(JSON.parse(response.body))
    Instagramimage.create_images(mash, user)
  end

  def self.faraday_connection
    base = "https://api.instagram.com"
    conn = Faraday.new(:url => base) do |c|
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Response::Logger   
      c.use Faraday::Adapter::NetHttp
    end
  end

  def self.create_images(mash, user)
    sign_up_time = user.authentications.find_by_provider('instagram').created_at
    
    mash.data.reverse.each do |gram|
      post_time = DateTime.strptime("#{gram.created_time}",'%s')
      if Instagramimage.find_by_source_id(gram.caption.id).blank? && post_time > sign_up_time
        image = Instagramimage.create(content: gram.images.standard_resolution.url,
                                      source_id: gram.caption.id,
                                      handle: gram.caption.from.username,
                                      post_time: post_time,
                                      caption: gram.caption.text,
                                      user_id: user.id)
        image.link_to_poly_post(image, user.feed)
      end
    end
  end
end

