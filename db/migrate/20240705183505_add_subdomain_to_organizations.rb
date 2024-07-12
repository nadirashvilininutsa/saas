class AddSubdomainToOrganizations < ActiveRecord::Migration[7.2]
  def change
    add_column :organizations, :subdomain, :string
    add_index :organizations, :subdomain, unique: true
  end
end
