class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  def create
    build_resource(invite_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        resource.organization = current_user.organization

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      respond_with resource
    end
  end

  def destroy
    @user = @organization.users.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'
  end

  protected

  # def authenticate_inviter!
  #   authenticate_admin!(force: true)
  # end

  # Permit the new params here.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :first_name, :last_name, :admin, :organization ])
  end

end
