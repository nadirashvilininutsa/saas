class Artifact < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validates :file, presence: true

  validate :file_size

  private

  def file_size
    if file.size > 10.megabytes
      errors.add(:file, "should be less than 10MB")
    end
  end
end
