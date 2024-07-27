class ChangeAdminToRoleInUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :admin, :boolean
    add_reference :users, :role, foreign_key: true
  end
end
