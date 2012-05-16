module Api::V1::DomainHelper
  def api_domain
    "http://api.#{request.domain}/v1/"
  end

  def api_path
    "http://#{request.domain}/api/v1/"
  end
end
