class Comment < ApplicationRecord
  belongs_to :organization, optional: false
  belongs_to :user, optional: false
  belongs_to :project, optional: false
  belongs_to :task, optional: false

  validates :content, presence: true
end
