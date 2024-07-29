class PlansController < ApplicationController
  before_action -> { has_required_permission?(:manage_organization) }

  def index
    @organization = current_user.organization
    @plans = Plan.all
  end

  private

  def has_required_permission?(permission)
    unless current_user.has_permission?(permission)
      redirect_to root_path, alert: "Access denied."
    end
  end
end