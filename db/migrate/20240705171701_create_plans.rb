class CreatePlans < ActiveRecord::Migration[7.2]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description

      t.timestamps
    end
  end
end
