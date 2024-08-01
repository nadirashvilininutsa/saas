class AddOrganizationToProjectsUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects_users, :organization, null: false, foreign_key: true
  end
end
