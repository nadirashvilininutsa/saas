class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :completion_date
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
