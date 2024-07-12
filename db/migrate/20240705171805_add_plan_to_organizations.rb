class AddPlanToOrganizations < ActiveRecord::Migration[7.2]
  def change
    add_reference :organizations, :plan, null: false, foreign_key: true
  end
end
