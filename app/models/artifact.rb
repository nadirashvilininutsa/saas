class Artifact < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validates :file, presence: true
end
