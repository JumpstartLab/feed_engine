class UrlInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.url_field(attribute_name, {:class => 'medium input-text'})}".html_safe
  end
end