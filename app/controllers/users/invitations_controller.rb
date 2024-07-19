class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, only: [:create]

  def create
    build_resource(invite_params)

    self.resource = invite_resource do |u|
      u.organization_id = current_user.organization.id
    end

    resource_invited = resource.errors.empty?
    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with(resource)
    end
  end

  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  # Permit new params
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :first_name, :last_name, :admin, :organization_id])
  end
end
