class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
    # @plans = Plan.all
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to new_user_registration_path(subdomain: @organization.subdomain)
    else
      render :new
    end
  end

  private

  def organization_params
    # params.require(:organization).permit(:name, :subdomain, :plan_id)
    params.require(:organization).permit(:name, :subdomain)
  end
end