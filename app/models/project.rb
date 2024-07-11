class Project < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :artifacts, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validate :must_have_at_least_one_user

  private

  def must_have_at_least_one_user
    errors.add(:users, "must have at least one user") if users.empty?
  end
end
