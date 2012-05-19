class Users::RegistrationsController < Devise::RegistrationsController

  def update 
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(params[:user])
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      @text_item = TextItem.new
      @link_item = LinkItem.new
      @image_item = ImageItem.new
      render :template => "dashboard/show"
    end
  end

  protected
  def after_sign_up_path_for(resource)
    external_accounts_url
  end  
end
