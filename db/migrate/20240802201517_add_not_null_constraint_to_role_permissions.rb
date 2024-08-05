class AddNotNullConstraintToRolePermissions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :role_permissions, :role_id, false
    change_column_null :role_permissions, :permission_id, false
  end
end
