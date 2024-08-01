class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :completed, null: false
      t.date :completion_date

      t.timestamps
    end
  end
end
