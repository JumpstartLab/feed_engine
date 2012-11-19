class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      dashboard_path
    end

end