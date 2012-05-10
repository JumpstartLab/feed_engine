class Link < ActiveRecord::Base
  attr_accessible :description, :poster_id, :url

  include ExternalContent

end
