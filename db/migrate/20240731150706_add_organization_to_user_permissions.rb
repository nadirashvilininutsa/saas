class AddOrganizationToUserPermissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :user_permissions, :organization, foreign_key: true
  end
end
