class AddNotNullConstraintToProjectsCompletionDate < ActiveRecord::Migration[7.2]
  def change
    change_column_null :projects, :completion_date, false
  end
end
