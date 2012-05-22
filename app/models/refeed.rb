class Refeed < ActiveRecord::Base
  attr_accessible :original_poster_id, :post_id, :refeeder_id
end
