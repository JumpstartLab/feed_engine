class FeedsController < ApplicationController
  def show
    @feed = Feed.find_by_name(request.subdomain)
  end
end
