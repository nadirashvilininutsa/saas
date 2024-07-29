class OrganizationsController < ApplicationController
  before_action -> { has_required_permission?(:manage_organization) }, only: [:change_plan]
  before_action -> { has_required_permission?(:add_delete_employees) }, only: [:show]


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
  
  private

  def has_required_permission?(permission)
    unless current_user.has_permission?(permission)
      redirect_to root_path, alert: "Access denied."
    end
  end
end