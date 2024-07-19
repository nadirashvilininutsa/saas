class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_one :admin_user, -> { where(admin: true) }, class_name: 'User'
  has_many :projects, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true

  before_validation :generate_subdomain, on: :create
  after_create :create_tenant


  private

  def generate_subdomain
    self.subdomain = name.parameterize(separator: '-')
  end

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
