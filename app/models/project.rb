class Project < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :artifacts, dependent: :destroy
  belongs_to :organization

  validates :title, presence: true
  validates :description, presence: true
  validates :completion_date, presence: true
  validate :must_have_at_least_one_user

  validate :free_plan_can_only_have_one_project


  # Scopes
  scope :active, -> { where(completed: false) }
  scope :archived, -> { where(completed: true) }

  
  private

  def must_have_at_least_one_user
    errors.add(:base, "Project must have at least one user") if users.empty?
  end

  def free_plan_can_only_have_one_project
    if organization&.plan&.name&.downcase == "free" && organization.projects.count > 1
      errors.add(:base, "Free plan can only have one project")
    end
  end
end
