class AddIndexesToTables < ActiveRecord::Migration[7.2]
  def change
    add_index :projects, :completed

    add_index :tasks, :completed
  end
end
