class PlansController < ApplicationController
  def index
    @organization = current_user.organization
    @plans = Plan.all
  end
end