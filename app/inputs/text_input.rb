class TextInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.text_area(attribute_name, {:class => 'niceTextarea'})}".html_safe
  end
end