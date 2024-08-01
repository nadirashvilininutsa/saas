class UserPermission < ApplicationRecord
  belongs_to :user
  belongs_to :permission
  belongs_to :organization
end
