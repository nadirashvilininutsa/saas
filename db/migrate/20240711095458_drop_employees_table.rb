class DropEmployeesTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :employees
  end

  def down
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :organization

      t.timestamps
    end
  end
end
