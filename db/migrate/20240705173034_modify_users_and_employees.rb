class ModifyUsersAndEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    remove_column :employees, :name, :string
    remove_column :employees, :email, :string
    remove_column :employees, :organization_id, :bigint

    add_reference :employees, :user, null: false, foreign_key: true
  end
end
