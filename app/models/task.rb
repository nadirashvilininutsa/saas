class Task < ApplicationRecord
  belongs_to :organization, optional: false
  belongs_to :user, optional: false
  belongs_to :project, optional: false

  has_many :comments, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :completion_date, presence: true, if: -> { completed? }
end
