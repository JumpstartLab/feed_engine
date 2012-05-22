# This is the constraint for matching routes with subdomains
class Subdomain
  def self.matches?(request)
    sub = request.subdomain if request.subdomain.present?
    sub && sub != 'www' && sub != 'api'
  end
end
