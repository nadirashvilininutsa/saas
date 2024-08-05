class AddForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :plan_description_plans, :plans, column: :plan_id
    add_foreign_key :plan_description_plans, :plan_descriptions, column: :plan_description_id

    add_foreign_key :projects_users, :users, column: :user_id
    add_foreign_key :projects_users, :projects, column: :project_id

    add_foreign_key :role_permissions, :permissions, column: :permission_id
    add_foreign_key :role_permissions, :roles, column: :role_id

    add_foreign_key :user_permissions, :users, column: :user_id
    add_foreign_key :user_permissions, :permissions, column: :permission_id
  end
end
