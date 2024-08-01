class AddUniqueIndexToOrganizationsName < ActiveRecord::Migration[7.2]
  def change
    add_index :organizations, :name, unique: true
  end
end
