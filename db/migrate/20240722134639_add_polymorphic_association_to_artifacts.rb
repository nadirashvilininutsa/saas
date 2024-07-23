class AddPolymorphicAssociationToArtifacts < ActiveRecord::Migration[7.2]
  def change
    remove_reference :artifacts, :project, foreign_key: true
    add_reference :artifacts, :artifactable, polymorphic: true, null: false
  end
end
