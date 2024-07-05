class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :organization, optional: false
  has_one :employee, dependent: :destroy
  scope :admins, -> { where(admin: true) }
  validates :first_name, :last_name, presence: true
  # after_create :create_employee

  accepts_nested_attributes_for :organization

  private

  # def create_employee
  #   Apartment::Tenant.switch!(organization.subdomain) do
  #     Employee.create(user: self)
  #   end
  # end
end
