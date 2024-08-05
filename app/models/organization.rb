class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :artifacts, dependent: :destroy

  has_many :projects_users, dependent: :destroy
  # has_many :users, through: :projects_users
  # has_many :projects, through: :projects_users

  has_many :user_permissions, dependent: :destroy
  # has_many :users, through: :user_permissions
  has_many :permissions, through: :user_permissions

  has_one :organization_admin, -> { where(role: "organization_admin") }, class_name: 'User'

  belongs_to :plan, optional: false

  validates :name, presence: true, uniqueness: true
end
