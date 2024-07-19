class AddOrganizationToProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects, :organization, null: false, foreign_key: true
  end
end
