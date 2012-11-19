module Subdomains
  def self.api
    lambda do |request|
      request.subdomain.present? && request.subdomain == 'api'
    end
  end

  def self.user_feeds
    lambda do |request|
      request.subdomain.present? && request.subdomain != 'www'
    end
  end
end
