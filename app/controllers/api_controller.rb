class ApiController < ApplicationController
  before_filter :authenticate

  attr_accessor :current_user

  private

  def construct_link_header(next_url, last_url)
    "<#{next_url}>; rel=\"next\", <#{last_url}>; rel=\"last\""
  end

  def authenticate
    if self.current_user = authenticate_or_request_with_http_basic do |username, password|
        login(username, password)
      end
    else
      request_http_basic_authentication
    end
  end
end
