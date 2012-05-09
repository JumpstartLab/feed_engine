class StringInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.text_field(attribute_name, {:class => 'medium input-text'})}".html_safe
  end
end