class AddNotNullConstraintToUserPermissions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :user_permissions, :user_id, false
    change_column_null :user_permissions, :permission_id, false
    change_column_null :user_permissions, :organization_id, false
  end
end
