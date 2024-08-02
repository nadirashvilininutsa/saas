class AddNotNullConstraintToProjects < ActiveRecord::Migration[7.2]
  def change
    change_column_null :projects, :completed, false
  end
end
