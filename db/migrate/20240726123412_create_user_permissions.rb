class CreateUserPermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :user_permissions do |t|
      t.integer :user_id
      t.integer :permission_id
    end
  end
end
