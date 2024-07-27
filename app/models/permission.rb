class Permission < ApplicationRecord
  has_many :user_permissions
  has_many :users, through: :user_permissions

  has_many :role_permissions
  has_many :roles, through: :role_permissions

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
