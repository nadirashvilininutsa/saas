class Users::RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    resource.build_organization
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    resource.admin = true

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        organization = Organization.new(organization_params)
        resource.organization = organization

        if !organization.save
          resource.destroy
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, organization_attributes: [:name, :plan_id])
  end

  def organization_params
    params.require(:organization).permit(:name, :plan_id)
  end
end