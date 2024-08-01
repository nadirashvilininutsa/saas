class MakeNameAndFileMandatoryInArtifacts < ActiveRecord::Migration[7.2]
  def change
    change_column_null :artifacts, :name, false
    change_column_null :artifacts, :file, false
  end
end
