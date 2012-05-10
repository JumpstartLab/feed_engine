module ApplicationHelper
  def flashes_helper
    results = []
    flash.each do |name, msg|
      results << content_tag(:div, content_tag(:p, msg), class: "alert alert-#{name}").html_safe
    end
    results.join("<br />").html_safe
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end


