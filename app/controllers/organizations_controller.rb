class OrganizationsController < ApplicationController
  # def new
  #   @organization = Organization.new
  #   @plans = Plan.all
  # end

  # def create
  #   @organization = Organization.new(organization_params)
  #   if @organization.save
  #     redirect_to new_user_registration_path(subdomain: @organization.subdomain)
  #   else
  #     render :new
  #   end
  # end

  def show
    @organization = current_user.organization
    @plan = Plan.find(@organization.plan_id)
    @users = @organization.users
  end

  def change_plan
    @organization = Organization.find(params[:id])
    plan_id = params[:plan_id]

    if @organization.update(plan_id: plan_id)
      redirect_to @organization, notice: 'Plan was successfully changed.'
    else
      redirect_to @organization, alert: 'Failed to change the plan.'
      # redirect_to organization_path(@organization), alert: 'Failed to change the plan.'
    end
  end
  
  # private

  # def organization_params
  #   # params.require(:organization).permit(:name, :subdomain, :plan_id)
  #   params.require(:organization).permit(:name, :subdomain)
  # end
end