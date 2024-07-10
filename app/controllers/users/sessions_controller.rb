# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  # after_action :switch_domain_to_public, only: [:destroy]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    redirect_to after_sign_in_path_for(resource), allow_other_host: true
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?

    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to root_url(subdomain: nil), allow_other_host: true, status: Devise.responder.redirect_status }
    end
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  # def switch_domain_to_public
  #   if !user_signed_in?
  #     Apartment::Tenant.switch('public')
  #   end
  # end

  def after_sign_in_path_for(resource)
    organization = Organization.find_by(id: resource.organization_id)
    if organization
      subdomain = organization.subdomain
      root_url(subdomain: subdomain)
    else
      root_url(subdomain: nil)
    end
  end
end
