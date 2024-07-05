class RemoveForeignKeyFromEmployees < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :employees, :organizations
  end
end
