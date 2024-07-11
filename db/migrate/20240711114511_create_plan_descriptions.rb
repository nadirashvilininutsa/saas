class CreatePlanDescriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :plan_descriptions do |t|
      t.text :contenct

      t.timestamps
    end
  end
end
