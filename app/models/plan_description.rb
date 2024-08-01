class PlanDescription < ApplicationRecord
  # has_and_belongs_to_many :plans
  has_many :plan_description_plans, dependent: :destroy
  has_many :plans, through: :plan_description_plans
end
