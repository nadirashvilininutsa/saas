class CreateJoinTablePlansPlanDescriptions < ActiveRecord::Migration[7.2]
  def change
    create_join_table :plans, :plan_descriptions do |t|
      t.index :plan_id
      t.index :plan_description_id
    end
  end
end
