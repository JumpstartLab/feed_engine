class Subdomain
  def self.matches?(request)
    request.subdomain.present? && !["www", "api", "ftp"].include?(request.subdomain.downcase)
  end
end