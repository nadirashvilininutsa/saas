class ModifyOrganizationsTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :organizations, :subdomain, :string
  end
end
