class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable, invite_for: 2.weeks
  
  has_many :projects_users
  has_many :projects, through: :projects_users
  belongs_to :organization, optional: false
  scope :admins, -> { where(admin: true) }
  validates :first_name, :last_name, presence: true

  accepts_nested_attributes_for :organization
end
