class RenameContenctToContentInPlanDescriptions < ActiveRecord::Migration[7.2]
  def change
    rename_column :plan_descriptions, :contenct, :content
  end
end
