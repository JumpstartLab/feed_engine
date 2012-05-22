class Refeed < ActiveRecord::Base
  include Postable
  include Service
  attr_accessible :original_poster_id, :post_id, :post_type

  def post
    post_type.capitalize.constantize.find(post_id)
  end
end
