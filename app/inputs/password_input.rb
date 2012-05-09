class PasswordInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.password_field(attribute_name, {:class => 'medium input-text'})}".html_safe
  end
end