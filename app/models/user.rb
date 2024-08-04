class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable, invite_for: 2.weeks

  belongs_to :organization, optional: false
  belongs_to :role, optional: false
  
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users
  has_many :organizations, through: :projects_users

  has_many :comments
  has_many :tasks
  has_many :artifacts

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions
  has_many :organizations, through: :user_permissions

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  accepts_nested_attributes_for :organization

  # Scopes for ACTIVE and ALL records
  default_scope { where(deleted_at: nil) }
  scope :with_deleted, -> { unscope(where: :deleted_at) }

  
  def deleted?
    deleted_at.present?
  end

  def has_permission?(permission)
    permission = permission.to_sym
    combined_permissions.include?(permission)
  end

  def list_user_permissions_based_role
    role.permissions.pluck(:name)
  end


  private

  def combined_permissions
    @combined_permissions ||= begin
      role_permissions = role.permissions.pluck(:name).map(&:to_sym)
      user_permissions = permissions.pluck(:name).map(&:to_sym)
      (role_permissions + user_permissions).uniq
    end
  end
end
