module ApplicationHelper
  def flashes_helper
    results = []
    flash.each do |name, msg|
      results << content_tag(:div, content_tag(:p, msg), class: name).html_safe
    end
    results.join("<br />").html_safe
  end
end


