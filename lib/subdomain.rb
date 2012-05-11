# This is the constraint for matching routes with subdomains
class Subdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end
