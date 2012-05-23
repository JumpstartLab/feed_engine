module ApplicationHelper
  def logo_url
    if current_user
      dashboard_url
    else
      root_url
    end
  end
end
