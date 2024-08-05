class AddNotNullConstraintToPlanDescriptionPlans < ActiveRecord::Migration[7.2]
  def change
    change_column_null :plan_description_plans, :plan_id, false
    change_column_null :plan_description_plans, :plan_description_id, false
  end
end
