class NoSubdomain
  def self.matches?(request)
    request.subdomain.empty? || request.subdomain == 'www'
  end
end