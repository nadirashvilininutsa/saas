class Artifact < ApplicationRecord
  mount_uploader :file, FileUploader
  belongs_to :artifactable, polymorphic: true

  belongs_to :organization, optional: false
  belongs_to :user, optional: false

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
