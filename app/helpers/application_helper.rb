module ApplicationHelper
  def logo_url
    if current_user
      dashboard_url(subdomain: current_user.display_name)
    else
      root_url(subdomain: false)
    end
  end
end
