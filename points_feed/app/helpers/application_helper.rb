module ApplicationHelper
  def flashes_helper
    results = []
    flashes = [:notice, :error, :alert, :success, :info]

    flashes.each do |name, msg|
      hidden = "hide" if flash[name].blank?
      results << content_tag(:div, content_tag(:p, flash[name]),
                 class: "alert alert-#{name} #{hidden}").html_safe
    end

    results.join("").html_safe
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


