class UserPermission < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :permission, optional: false
  belongs_to :organization, optional: false
end
