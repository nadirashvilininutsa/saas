class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  # before_action :set_tenant, if: :user_signed_in?

  def index
  end

  # private
  # 
  # def set_tenant
  #   if current_user
  #     tenant_name = session[:tenant_name] || current_user.tenants.first.name
  #     Apartment::Tenant.switch!(tenant_name)
  #     @tenant = Tenant.find_by(name: tenant_name)
  #     params[:tenant_id] = @tenant.id
  #   end
  # end
end
