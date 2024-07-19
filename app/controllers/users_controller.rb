class UsersController < ApplicationController
  def index
    current_organization = current_user.organization
    @users = User.where(organization_id: current_organization.id).order(:first_name)
  end

  def toggle_user_status
    @user = User.find(params[:id])

    if @user.admin?
      @user.update(admin: false)
      redirect_to users_path, notice: "#{@user.first_name} #{@user.last_name} is no longer an admin."
    else
      @user.update(admin: true)
      redirect_to users_path, notice: "#{@user.first_name} #{@user.last_name} is now an admin."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end
end
