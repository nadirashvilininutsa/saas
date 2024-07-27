class CreateRolePermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :role_permissions do |t|
      t.integer :role_id
      t.integer :permission_id
    end
  end
end
