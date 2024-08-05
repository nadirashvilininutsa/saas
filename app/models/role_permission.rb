class RolePermission < ApplicationRecord
  belongs_to :role, optional: false
  belongs_to :permission, optional: false
end
