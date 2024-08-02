class PlanDescription < ApplicationRecord
  has_many :plan_description_plans, dependent: :destroy
  has_many :plans, through: :plan_description_plans
  
  validates :content, presence: true, uniqueness: true
end
