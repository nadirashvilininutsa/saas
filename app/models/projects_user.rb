class ProjectsUser < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :organization
end
