class UpdateOrganizationsTable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :organizations, :name, false
    remove_column :organizations, :subdomain, :string
  end
end
