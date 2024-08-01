class Task < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :project

  has_many :comments, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :completion_date, presence: true, if: -> { completed? }
end
