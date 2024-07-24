class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_one :admin_user, -> { where(admin: true) }, class_name: 'User'
  has_many :projects, dependent: :destroy

  validates :name, presence: true, uniqueness: true


  private
end
