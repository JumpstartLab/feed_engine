class TextInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:class] << "oversize input-text"
    "#{@builder.text_area(attribute_name, input_html_options)}".html_safe
  end
end