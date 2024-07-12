class ChangeJoinTableForPlansAndPlanDescriptions < ActiveRecord::Migration[7.2]
  def change
    drop_table :plan_descriptions_plans

    create_table :plan_description_plans do |t|
      t.integer :plan_id
      t.integer :plan_description_id
    end
  end
end
