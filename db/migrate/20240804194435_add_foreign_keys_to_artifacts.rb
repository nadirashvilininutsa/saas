class AddForeignKeysToArtifacts < ActiveRecord::Migration[7.2]
  def change
    add_reference :artifacts, :organization, foreign_key: true, null: false
    add_reference :artifacts, :user, foreign_key: true, null: false
  end
end
