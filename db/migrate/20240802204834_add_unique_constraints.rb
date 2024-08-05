class AddUniqueConstraints < ActiveRecord::Migration[7.2]
  def change
    add_index :plan_descriptions, :content, unique: true
    add_index :plans, :name, unique: true
    add_index :projects, :title, unique: true
  end
end
