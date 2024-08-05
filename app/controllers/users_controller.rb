class UsersController < ApplicationController
  before_action -> { has_required_permission?(:view_employees) }, only: [:index]
  before_action -> { has_required_permission?(:manage_user_roles) }, only: [:change_role]
  before_action -> { has_required_permission?(:manage_user_permissions) }, only: [:update_permissions]
  before_action -> { has_required_permission?(:add_delete_employees) }, only: [:destroy]

  def index
    current_organization = current_user.organization
    @users = User.where(organization_id: current_organization.id).order(:first_name)
  end

  def change_role
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_id])

    if role
      @user.update(role: role)
      duplicated_permissions = role.permission_ids & @user.permission_ids

      duplicated_permissions.each do |permission_id|
        UserPermission.where(permission_id: permission_id).delete_all
      end

      redirect_to organization_path(current_user.organization), notice: "#{@user.first_name} #{@user.last_name} is now #{role.name}."
    
    else
      redirect_to organization_path(current_user.organization), alert: "#{@user.first_name} #{@user.last_name}`s role could not be updated. Role not found."
    end
  end

  def update_permissions
    @user = User.find(params[:id])
    
    if params[:user][:permission_ids]
      updated_permission_ids = params[:user][:permission_ids].reject(&:blank?).map(&:to_i)
      current_permission_ids = @user.permission_ids

      permissions_to_add = updated_permission_ids - current_permission_ids
      permissions_to_remove = current_permission_ids - updated_permission_ids
    
      permissions_to_add.each do |permission_id|
        UserPermission.create(user: @user, permission_id: permission_id, organization: @user.organization)
      end
    
      permissions_to_remove.each do |permission_id|
        UserPermission.where(user: @user, permission_id: permission_id).destroy_all
      end

      if @user.save
        redirect_to organization_path(current_user.organization), notice: "#{@user.first_name} #{@user.last_name}'s permissions were successfully updated."
      else
        redirect_to organization_path(current_user.organization), alert: "Failed to update permissions for #{@user.first_name} #{@user.last_name}."
      end
    else
      @user.permissions.delete_all
      redirect_to organization_path(current_user.organization), alert: "All additional permissions removed from #{@user.first_name} #{@user.last_name}."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(deleted_at: Time.current)
    redirect_to root_path, notice: 'User was successfully deleted.'
  end


  private

  def has_required_permission?(permission)
    unless current_user.has_permission?(permission)
      redirect_to root_path, alert: "Access denied."
    end
  end
end



# <td class="">
# <% user.permissions.each do |permission| %>
#   <%= permission.name %>
# <% end %>

# <% if current_user.has_permission?(:manage_user_permissions) %>
#   <a class="toggle-button mt-1 btn btn-outline-primary">Edit additional permissions</a>
#   <%= form_with model: user, url: update_permissions_user_path(user), class: "hidden", data: { method: :patch}, local: true do |form| %>
#     <% Permission.all.each do |permission| %>
#       <% unless user.list_user_permissions_based_role.include?(permission.name) %>
#         <div class="form-check">
#           <%= form.check_box :permission_ids, { multiple: true, class: 'form-check-input', checked: user.permissions.include?(permission) }, permission.id, nil %>
#           <%= form.label :permission_ids, permission.name, class: 'form-check-label' %>
#         <% end %>
#       </div>
#     <% end %>
#     <%= form.submit 'Update', class: 'btn btn-primary mt-2' %>
#   <% end %>
# <% end %>
# </td>