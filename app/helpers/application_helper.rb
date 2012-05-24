module ApplicationHelper
  def logo_url
    if current_user
      dashboard_url(subdomain: false)
    else
      root_url(subdomain: false)
    end
  end
end
