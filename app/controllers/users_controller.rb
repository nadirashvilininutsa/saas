class UsersController < ApplicationController
  def index
    current_organization = current_user.organization
    @users = User.where(organization_id: current_organization.id).order(:first_name)
  end

  def change_role
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_id])
    if role
      @user.update(role: role)
      redirect_to users_path, notice: "#{@user.first_name} #{@user.last_name} is now #{role.name}."
    else
      redirect_to users_path, alert: "#{@user.first_name} #{@user.last_name}`s role could not be updated. Role not found."
    end
  end

  def update_permissions
    @user = User.find(params[:id])
    
    if params[:user][:permission_ids]
      permission_ids = params[:user][:permission_ids].reject(&:blank?)
      @user.permission_ids = permission_ids

      if @user.save
        redirect_to users_path, notice: "#{@user.first_name} #{@user.last_name}'s permissions were successfully updated."
      else
        redirect_to users_path, alert: "Failed to update permissions for #{@user.first_name} #{@user.last_name}."
      end
    else
      @user.permissions.delete_all
      redirect_to users_path, alert: "All additional permissions removed from #{@user.first_name} #{@user.last_name}."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
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