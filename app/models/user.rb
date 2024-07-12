class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  has_and_belongs_to_many :projects
  belongs_to :organization, optional: false
  scope :admins, -> { where(admin: true) }
  validates :first_name, :last_name, presence: true

  accepts_nested_attributes_for :organization
end
