class ProjectsUser < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :project, optional: false
  belongs_to :organization, optional: false
end
