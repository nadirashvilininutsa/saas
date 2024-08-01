class Comment < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :project
  belongs_to :task

  validates :content, presence: true
end
