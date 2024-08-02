class AddIndexesToForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_index :plan_description_plans, :plan_id
    add_index :plan_description_plans, :plan_description_id

    add_index :role_permissions, :role_id
    add_index :role_permissions, :permission_id

    add_index :user_permissions, :user_id
    add_index :user_permissions, :permission_id
  end
end
