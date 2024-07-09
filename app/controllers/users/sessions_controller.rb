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

    after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    # super do
    #   redirect_to main_app.root_url(subdomain: nil), allow_other_host: true and return
    # end

    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    # respond_to_on_destroy
    redirect_to root_url(subdomain: nil), allow_other_host: true and return

  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def switch_domain_to_public
    if !user_signed_in?
      Apartment::Tenant.switch('public') do 
      end
    end
  end

  def after_sign_in_path_for(resource)
    organization = Organization.find_by(id: resource.organization_id)
    if organization
      subdomain = organization.subdomain
      Apartment::Tenant.switch(subdomain) do 
      end
      redirect_to root_url(subdomain: subdomain), allow_other_host: true and return
    end
  end
end
