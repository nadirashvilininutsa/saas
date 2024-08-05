class AddNotNullConstraintToPlanDescriptions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :plan_descriptions, :content, false
  end
end
