class PlanDescription < ApplicationRecord
  has_and_belongs_to_many :plans
end
